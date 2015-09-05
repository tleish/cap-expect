require 'yaml'

module CapExpect
  module Printers

    class Details
      def initialize(configs, include_detail=true)
        @configs = configs
        @include_detail = include_detail
        @hosts = []
      end

      def to_yaml
        hash.to_yaml
      end

      def hash
        @configs.each_with_object({}) do |config, hash|
          next if config.attributes.nil?
          hash[config.basename] ||= detail(config.attributes)
          config.attributes.roles.each do |name, capistrano_role|
            hash[config.basename][name] = capistrano_role.map(&:host)
          end
        end
      end

      def by_hosts
        hosts = @configs.each_with_object({}) do |config, hash|
          next if config.attributes.nil?
          config.attributes.roles.values.each do |capistrano_role|
            capistrano_role.each do |host|
              hash[host] = detail(config.attributes)
            end
          end
        end

        hosts.keys.sort.each_with_object({}) { |host, hash| hash[host] = hosts[host] }
      end

      private

      def detail(attributes)
        return {} unless @include_detail
        {
          application: attributes.application,
          gateway: attributes.respond_to?(:gateway) ? attributes.gateway : nil,
          branch: attributes.branch,
          deploy_to: attributes.deploy_to
        }
      end

    end

  end

end