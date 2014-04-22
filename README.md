# exacttarget-soap-ruby

This repo is a collection of examples for accessing [ExactTarget][0]'s SOAP API with Ruby using the Savon Gem. 

## Prerequisites

### Required Ruby Gems
- Savon

### Required Ruby Version
1.9.3

## Getting Started ##

- Copy the creds.rb.template file to creds.php
- Open creds.rb and input the appropriate values for username/password and WSDL
 - Requires an ExactTarget user with 'API User' and 'Grant the user access to the web services' permissions
- Navigate to samples directory
- Run the getsystemstatus.rb script
- Successful response will include StatusCode of OK:

Example:

    {
		:results=>
			{
			:result=>
				{
					:status_code=>"OK", 
					:status_message=>"System Status Retrieved", 
					:system_status=>"OK"}
				}, 
			:overall_status=>"OK",
			:overall_status_message=>nil,
			:request_id=>"7a5aba84-2c05-462c-9ae1-e18fb9887449",
			:@xmlns=>"http://exacttarget.com/wsdl/partnerAPI"
	}

### Questions about ExactTarget's SOAP API? ###

Check out: [https://salesforce.stackexchange.com/questions/tagged/exacttarget](https://salesforce.stackexchange.com/questions/tagged/exacttarget) 

[0]: http://www.exacttarget.com
