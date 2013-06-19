require_relative "../lib/device_discovery"
require_relative "../lib/client"


EM.run do
    ONVIF::DeviceDiscovery.start do |device|
        puts device.inspect
        puts "=================="
    end

    client = ONVIF::Client.new({
        address: 'http://192.168.2.145/onvif/device_service'
    })
    
    device_info_message = %Q{
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:wsdl="http://www.onvif.org/ver10/device/wsdl">
   <soap:Header/>
   <soap:Body>
      <wsdl:GetDeviceInformation/>
   </soap:Body>
</soap:Envelope>
    }

    client.send(device_info_message) do |success, result|
        puts success
        puts result.inspect
    end
end

