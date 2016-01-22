# This call will add a record to a pre-exisiting data extension
# This example assumes a data extension is already created with an external key of SimpleExample
# The data extension has fields for EmailAddress and FirstName
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

dataextensionobject = {}
dataextensionobject['@xsi:type'] = "tns:DataExtensionObject"
dataextensionobject['CustomerKey'] =  "SimpleExample";
dataextensionobject['Properties'] =  {'Property'=>[ {'Name'=>'EmailAddress', 'Value'=>'example@example.com'},{'Name'=>'FirstName', 'Value'=>'Mac'}] }

response = et_client.call(:create, :message => {'Objects' => dataextensionobject})

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
        results.each {|result| p "Failed due to: #{result[:status_code]} #{result[:error_code]} #{result[:error_message]}"}
    end
end