# This call will send an email.  It requires that a TriggeredSendDefinition already exist in the account.
# The existing TriggeredSendDefinition is referenced by CustomerKey (referred to as External Key in the interface). 
# A TriggeredSendDefinition will need to be in a running state before it can be used to send emails. 
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

triggeredsend = {}
triggeredsend['@xsi:type'] = "tns:TriggeredSend"
triggeredsend['TriggeredSendDefinition'] = {'CustomerKey' => "TEXTEXT" }
triggeredsend['Subscribers'] = {"EmailAddress" => "Example@bh.exacttarget.com", "SubscriberKey" => "Example@exacttarget.com"}
triggeredsend['Subscribers']['Attributes'] = [{"Name" =>"First Name", "Value" => "Example"}, {"Name" =>"Last Name", "Value" => "Smith"}]

response = et_client.call(:create, :message => {'Objects' => triggeredsend})

if !response.nil? then 
	envelope = response.hash[:envelope]

	createresponse = envelope[:body][:create_response]
	if createresponse[:overall_status] == "OK"
		p 'Success'
	else 
		p 'Failed'
		results = createresponse[:results]
		if !results.kind_of?(Array)
			results = [results]
		end 
		results.each {|result| p "Failed due to: #{result[:subscriber_failures][:error_description]}"}
	end 
end

