module TenderSummary
  class TenderApi
    include HTTParty

    headers  'Accept' => 'application/vnd.tender-v1+json'
    format   :json
    parser   Proc.new { |body| add_json_helpers(Crack::JSON.parse(body)) }

    class << self
      attr_accessor :subdomain, :username, :password
    end

    def self.authenticate(subdomain = nil, username = nil, password = nil)
      self.subdomain ||= subdomain
      self.username  ||= username
      self.password  ||= password

      basic_auth(self.username, self.password)
      base_uri(HTTParty.normalize_base_uri(site_href))
    end

    def self.discussions(options = {})
      get(site.href(:discussions, options))
    end

    def self.site
      @site ||= get(site_href)
    end

    def self.base
      @base ||= get('https://api.tenderapp.com/')
    end

    def self.site_href
      @site_href ||= base.href('site', :site_permalink => subdomain)
    end

    # Make the JSON a litte bit more fun to work with
    def self.add_json_helpers(data)
      case data
      when Hash
        data.send(:extend, TenderSummary::JsonHelpers)
        data.each { |_, value| add_json_helpers(value) }
      when Array
        data.each { |elem| add_json_helpers(elem) }
      end

      data
    end
  end

  module JsonHelpers
    def href(key, options = {})
      Addressable::Template.new(self["#{key}_href"]).expand(options).to_s
    end
  end
end