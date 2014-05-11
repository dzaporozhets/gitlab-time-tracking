class User
  attr_reader :attributes

  def self.authenticate(params)
    url = params.delete('url')
    client = Gitlab.client(endpoint: url + '/api/v3/')
    response = client.session(params['email'], params['password'])

    if response
      User.new(response.to_hash.merge("url" => url))
    end
  end

  def initialize(hash)
    @attributes = hash
  end

  def method_missing(meth, *args, &block)
    if attributes.has_key?(meth.to_s)
      attributes[meth.to_s]
    else
      super
    end
  end

  def projects
    client = Gitlab.client(endpoint: self.url + '/api/v3/', private_token: self.private_token)
    client.projects
  end

  def project(id)
    client = Gitlab.client(endpoint: self.url + '/api/v3/', private_token: self.private_token)
    client.project(id)
  end

  def to_hash
    @attributes
  end
end
