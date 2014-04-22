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

response = et_client.call(:get_system_status, :message => nil)

if !response.nil? then 
	envelope = response.hash[:envelope]
	ssresponse = envelope[:body][:system_status_response_msg]
	p ssresponse
	
=begin	
	if ssresponse[:overall_status] == "OK"
		p 'Success' 
		p 'Details'
		results = retrieveresponse[:results]
		if !results.kind_of?(Array)
			results = [results]
		end 

		results.each {|list| p "ListID: #{list[:id]} #{list[:list_name]}"}
	end 
=end	
end

