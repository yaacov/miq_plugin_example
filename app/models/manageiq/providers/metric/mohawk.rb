class ManageIQ::Providers::Metric::Mohawk < ManageIQ::Providers::BaseManager
  extend ActiveSupport::Concern

  # This is the API version that we use and support throughout the entire code
  # (parsers, events, etc.). It should be explicitly selected here and not
  # decided by the user nor out of control in the defaults of kubeclient gem
  # because it's not guaranteed that the next default version will work with
  # our specific code in ManageIQ.
  delegate :api_version, :to => :class

  def self.raw_api_endpoint(hostname, port, path = '')
    URI::HTTPS.build(:host => hostname, :port => port.presence.try(:to_i), :path => path)
  end

  def self.mohawk_connect(hostname, port, options)
    require 'kubeclient'

    Kubeclient::Client.new(
      raw_api_endpoint(hostname, port, options[:path]),
      options[:version] || kubernetes_version,
      :ssl_options    => Kubeclient::Client::DEFAULT_SSL_OPTIONS.merge(options[:ssl_options] || {}),
      :auth_options   => kubernetes_auth_options(options),
      :http_proxy_uri => VMDB::Util.http_proxy_uri,
      :timeouts       => {
        :open => Settings.ems.ems_kubernetes.open_timeout.to_f_with_method,
        :read => Settings.ems.ems_kubernetes.read_timeout.to_f_with_method
      }
    )
  end

  def self.mohawk_auth_options(options)
    {}
  end

  def self.mohawk_version
    "0.21.0"
  end

  def api_version=(_value)
    raise 'Mohawk api_version cannot be modified'
  end

  def self.api_version
    mohawk_version
  end

  def self.ems_type
    @ems_type ||= "mohawk".freeze
  end

  def self.description
    @description ||= "Mohawk".freeze
  end

  def self.raw_connect(hostname, port, options)
    mohawk_connect(hostname, port, options)
  end
end
