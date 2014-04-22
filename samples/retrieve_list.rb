require 'savon'
require '../creds.rb' #This is used to set values for $wsdl, $endpoint, $username, and $password

et_client = Savon.client(
	wsdl: $wsdl,
	endpoint: $endpoint,
	wsse_auth: [$username, $password],
	raise_errors: false,
	log: false,
	open_timeout:180,
	read_timeout: 180
  )

rqst = {}
rqst['ObjectType'] = 'List'
rqst['Properties'] = ['ID', 'ListName','Description','Category']

#Example Simple Filter
=begin
filter = {'@xsi:type' => 'tns:SimpleFilterPart'}
filter['Property'] = 'ID'
filter['SimpleOperator'] = 'equals'
filter['Value'] = '2000935'
rqst['Filter'] = filter
=end 

#Example Complex Filter
filterOne = {'@xsi:type' => 'tns:SimpleFilterPart'}
filterOne['Property'] = 'ID'
filterOne['SimpleOperator'] = 'equals'
filterOne['Value'] = '2000935'

filterTwo = {'@xsi:type' => 'tns:SimpleFilterPart'}
filterTwo['Property'] = 'ListName'
filterTwo['SimpleOperator'] = 'equals'
filterTwo['Value'] = 'Test'

complexFilter = {'@xsi:type' => 'tns:ComplexFilterPart'}
complexFilter['LeftOperand'] = filterOne
complexFilter['RightOperand'] = filterTwo
complexFilter['LogicalOperator'] = 'OR'
rqst['Filter'] = complexFilter
  
rqstmsg = {'RetrieveRequest' => rqst}
response = et_client.call(:retrieve, :message => rqstmsg)

if !response.nil? then 
	envelope = response.hash[:envelope]
	retrieveresponse = envelope[:body][:retrieve_response_msg]

	if retrieveresponse[:overall_status] == "OK"
		p 'Success' 
		results = retrieveresponse[:results]
		if !results.kind_of?(Array)
			results = [results]
		end 

		results.each {|list| p "ListID: #{list[:id]} #{list[:list_name]}"}
	end 
end

