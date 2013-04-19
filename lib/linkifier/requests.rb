module Linkifier
  module Requests
    protected

    def self.convert_uri(uri)
      uri.scheme = Rails.env.production? ? 'https' : 'http'
      URI(uri.to_s)
    end

    def self.http_request(uri, request)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = Rails.env.production?
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.ca_file = Linkifier.ca_file_path
      http.request(request)
    end

    def self.is_integer?(str)
      Integer(str) rescue false
    end

    def self.linkify_resources_url(format = "")
      convert_uri(URI(Linkifier.linkify_url) + ("/resources#{}" + (format.blank? ? "" : ".#{format}")))
    end

    def self.linkify_resource_url(id, format = "")
      convert_uri(URI(Linkifier.linkify_url) + ("/resources/#{id}" + (format.blank? ? "" : ".#{format}")))
    end

    public

    def self.get_linkify_resources
      uri = linkify_resources_url(:json)
      uri.query = URI.encode_www_form(:auth_token => Linkifier.authentication_token)

      request = Net::HTTP::Get.new(uri.request_uri)

      response = http_request(uri, request)
      response if response.kind_of? Net::HTTPSuccess
    end

    def self.create_linkify_resource(app_resource)
      config = app_resource.linkify_config
      uri = linkify_resources_url(:json)

      request = Net::HTTP::Post.new(uri.request_uri)
      resource_type_key = is_integer?(config.resource_type) ? "id" : "name"
      request.set_form_data("auth_token" => Linkifier.authentication_token,
                            "resource[name]" => config.name_proc.call(app_resource),
                            "resource[url]" => config.url_proc.call(app_resource),
                            "resource[is_permalink]" => config.permalink,
                            "resource[resource_type_#{resource_type_key}]" => config.resource_type)

      response = http_request(uri, request)
      response if response.kind_of? Net::HTTPSuccess
    end

    def self.destroy_linkify_resource(id)
      uri = linkify_resource_url(id, :json)

      request = Net::HTTP::Delete.new(uri.request_uri)
      request.set_form_data(:auth_token => Linkifier.authentication_token)

      response = http_request(uri, request)
      response if response.kind_of? Net::HTTPSuccess
    end
  end
end
