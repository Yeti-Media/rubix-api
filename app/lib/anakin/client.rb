module Anakin
  class GeneralError < Exception
  end

  class ArgumentError < Exception

  end

  class Client

    def valid?
      validate
    end

    def request(body)
      response = client.post do |req|
        req.url '/'
        req.headers['Content-Type'] = 'application/json'
        req.body = Yajl::Encoder.encode(body)
      end
      Yajl::Parser.parse(response.body)
    end
    
    protected

    def validate
      true
    end

    def client
      @client ||= begin 
        host = Settings.anakin.load_balancer.host
        port = Settings.anakin.load_balancer.port
        Faraday.new(url: "http://#{host}:#{port}/")
      end
    end
     
  end
end
