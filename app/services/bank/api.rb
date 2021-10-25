# frozen_string_literal: true

require 'httparty'

class Bank::Api

  AUTH_TOKEN=Rails.application.credentials[:BANK_CLIENT_AUTH_TOKEN]
  CLIENT_ID=Rails.application.credentials[:BANK_CLIENT_ID]
  BASE_URL=Rails.application.credentials[:BANK_BASE_URL]

	class << self
		def cash_out(params)
		  request(:post, '/cash_out', body: params.merge(client_id: CLIENT_ID).to_json)
		end

		private
    
    def request(method, path, options)
      default_headers = { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{AUTH_TOKEN}" }
      options[:headers] = { **(options[:headers] || {}), **default_headers }
      
      response = HTTParty.send(method, "#{BASE_URL}#{path}", options)
    end
  end
end