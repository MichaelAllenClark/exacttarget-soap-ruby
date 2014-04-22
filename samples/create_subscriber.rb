# This call will create a Subscriber record.
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

subscriber = {}
subscriber['@xsi:type'] = "tns:Subscriber"
subscriber['EmailAddress'] = 'RubyTesting6@bh.exacttarget.com'
subscriber['Lists'] = {'ID' => '1719338'}
subscriber['Attributes'] = [{"Name" =>"First Name", "Value" => "Example"}, {"Name" =>"Last Name", "Value" => "Smith"}]

opts = {}
# Uncomment the line below in order to do an UpdateAdd (aka Upsert) for the Subscriber
#opts = {'SaveOptions' => [{'SaveOption' => {'PropertyName'=> "*", 'SaveAction' => "UpdateAdd"}}]}

response = et_client.call(:create, :message => {'Objects' => subscriber, 'Options' => opts})

if !response.nil? then 
	envelope = response.hash[:envelope]

	createresponse = envelope[:body][:create_response]
	results = createresponse[:results]
	if !results.kind_of?(Array)
		results = [results]
	end 
	
	if createresponse[:overall_status] == "OK"
		p 'Success' 
		results.each {|result| p "Subscriber: #{result[:object][:id]} #{result[:object][:email_address]}"}
	else 
		p 'Failed' 
		results.each {|result| p "Failure Message: #{result[:status_message]}"}
	end 
end

