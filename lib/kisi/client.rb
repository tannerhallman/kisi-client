require "kisi/client/version"
require "httparty"
require "rest_client"

module Kisi
  class Client
    include HTTParty

    debug_output STDOUT
    # @debug = false
    attr_reader :token

    def initialize(token)
      @token = token
      #base_uri "https://api.getkisi.com"
      @base_uri = "https://private-anon-078fb5ecdb-kisiapi.apiary-mock.com"
      #@debug = true # todo remove for production
      #set_debug_url
      @headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json",
        "Authorization" => "KISI-LOGIN #{@token}",
      }
    end

    def debug_enabled(is_enabled = true)
      @debug = is_enabled
      #set_debug_url
    end

    def set_debug_url
      if @debug
        @base_uri = "https://private-anon-078fb5ecdb-kisiapi.apiary-mock.com"
      end
    end

    def add_headers(options)
      # Content-Type:application/json
      # Accept:application/json
      # Authorization:KISI-LOGIN <Token>
      options = options.merge!({
        headers: {
          "Authorization": "KISI-LOGIN #{@token}",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      })
      return options
    end

    def get_users(options: {})
      self.class.get("/user", add_headers(options)).parsed_response
    end

    def create_user(name:, email:, password:, options: {})
  
      uri = URI.parse("#{@base_uri}/users/sign_up")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
​
      request["Content-Type"] = "application/json"
      request["Accept"] = "application/json"
      request["Authorization"] = "KISI-LOGIN #{@token}"
​
      body = {
          user: {
            :email => "vdbrown2@ncsu.edu",
            :password  => "testing123",
            :name => "DeShawn",
            :terms_and_conditions => true
      }
    }
    request.body = body.to_json
    response = http.request(request)
    end

    def get_groups(options: {})
      self.class.get("/groups", add_headers(options)).parsed_response
    end

    def get_places(options: {})
      self.class.get("/places", add_headers(options)).parsed_response
    end

    def get_locks(options: {})
      self.class.get("/locks", add_headers(options)).parsed_response
    end

    def unlock_lock(lock)
      # not ready
      self.class.post(
        "/locks/#{lock["id"]}/unlock",
        {body: {lock: lock}}
      )
    end
  end
end
