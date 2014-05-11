class User
  attr_reader :attributes

  def self.authenticate(params)
    url = params.delete('url')

    response = Network.new.authenticate(url, params)

    if response
      User.new(response.merge("url" => url))
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
end
