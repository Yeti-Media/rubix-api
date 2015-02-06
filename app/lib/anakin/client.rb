module Anakin
  class GeneralError < Exception
  end

  class ArgumentError < Exception

  end

  class Client

    def valid?
      validate
    end

    def perform(body,service = "load_balancer")
      response = client(service).post do |req|
        req.url '/'
        req.headers['Content-Type'] = 'application/json'
        req.body = Yajl::Encoder.encode(body)
      end
      begin
        Yajl::Parser.parse(response.body)
      rescue Yajl::ParseError
        if response.body == "OK" 
          return {status: 'OK'}
        else
          return {error: "OOOOPPS. Unknown error"}
        end
      end
    end
    
    protected

    def validate
      true
    end

    def client(service = "load_balancer")
      @client ||= {}
      @client[service] ||= begin 
        host = Settings.anakin[service]["host"]
        port = Settings.anakin[service]["port"]
        Faraday.new(url: "http://#{host}:#{port}/")
      end
    end
     
  end
end
