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
        :content_type => "application/json",
        :accept => "application/json",
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
      #   "name": "First Last",
      # "email": "email@domain.com",
      # "password": "test1234",
      # "terms_and_conditions": true
      # todo password must be 8 characters!
      # new_options = options.merge!({
      #   body: {
      #     user: {
      #       name: name,
      #       email: email,
      #       password: password,
      #       terms_and_conditions: true,
      #     },
      #   }.to_json,
      # })
      # puts "OPTIONS!!!: " + options.to_s
      # # self.class.post("/users/#{signup_token}/sign_up", add_headers(options)).parsed_response
      # new_options = add_headers(new_options)
      # puts "NEW OPTIONS!!" + new_options.to_s
      # self.class.post("/users/sign_up", new_options).parsed_response

      body = {
        user: {
          email: email,
          name: name,
          password: password,
          terms_and_conditions: true,
        },
      }.to_json

      url = "#{@base_uri}/users/sign_up"
      puts url
      response = RestClient.post url, body, @headers
      puts response
      return response
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
