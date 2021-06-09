module Aws
  # Base class for all {Aws} service clients.
  class Client < Seahorse::Client::Base

    # @api private
    DEFAULT_PLUGINS = [
      'Seahorse::Client::Plugins::ContentLength',
      'Aws::Plugins::Logging',
      'Aws::Plugins::ParamConverter',
      'Aws::Plugins::ParamValidator',
      'Aws::Plugins::UserAgent',
      'Aws::Plugins::HelpfulSocketErrors',
      'Aws::Plugins::RetryErrors',
      'Aws::Plugins::GlobalConfiguration',
      'Aws::Plugins::RegionalEndpoint',
      'Aws::Plugins::RequestSigner',
      'Aws::Plugins::ResponsePaging',
      'Aws::Plugins::StubResponses',
      'Aws::Plugins::IdempotencyToken',
      'Aws::Plugins::JsonvalueConverter',
      'Aws::Plugins::EndpointDiscovery',
      'Aws::Plugins::EndpointPattern'
    ]

    # @api private
    PROTOCOL_PLUGINS = Hash.new(DEFAULT_PLUGINS).merge({
      'json'      => DEFAULT_PLUGINS + %w(Aws::Plugins::Protocols::JsonRpc),
      'rest-json' => DEFAULT_PLUGINS + %w(Aws::Plugins::Protocols::RestJson),
      'rest-xml'  => DEFAULT_PLUGINS + %w(Aws::Plugins::Protocols::RestXml),
      'query'     => DEFAULT_PLUGINS + %w(Aws::Plugins::Protocols::Query),
      'ec2'       => DEFAULT_PLUGINS + %w(Aws::Plugins::Protocols::EC2),
    })

    include ClientStubs
    include ClientWaiters

    class << self

      # @return [Symbol]
      # @api private
      attr_accessor :identifier

      # @api private
      def define(svc_name, options)
        client_class = Class.new(self)
        client_class.identifier = svc_name.downcase.to_sym
        client_class.set_api(Api::Builder.build(options[:api], options))
        client_class.set_waiters(options[:waiters])

        protocol = client_class.api.metadata['protocol']
        PROTOCOL_PLUGINS[protocol].each do |plugin|
          client_class.add_plugin(plugin)
        end

        Api::Customizations.apply_plugins(client_class)

        soft_deprecation
        client_class
      end

      private

      def soft_deprecation
        unless @warned
          @warned = true
          warn(
            "Version 2 of the Ruby SDK will enter maintenance mode as of "\
            "November 20, 2020. To continue receiving service updates and new "\
            "features, please upgrade to Version 3. More information can be "\
            "found here: https://aws.amazon.com/blogs/developer/"\
            "deprecation-schedule-for-aws-sdk-for-ruby-v2/"
          )
        end
      end

    end
  end
end
