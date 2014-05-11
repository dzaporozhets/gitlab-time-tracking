require 'httparty'

class Network
  include HTTParty

  API_PREFIX = '/api/v3/'

  def authenticate(url, api_opts)
    opts = {
      body: api_opts.to_json,
      headers: {"Content-Type" => "application/json"},
    }

    endpoint = File.join(url, API_PREFIX, 'session.json')
    response = self.class.post(endpoint, opts)

    if response.code == 201
      response.parsed_response
    else
      nil
    end
  end
end
