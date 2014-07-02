require 'netscaler/netscaler_service'

module Netscaler
  class StringMap < NetscalerService
    def initialize(netscaler)
      @netscaler = netscaler
    end

    def get_pattern_binding(payload)
      raise ArgumentError, 'arg must contain name of policystringmap!' if payload.nil?
      return @netscaler.adapter.get("config/policystringmap_pattern_binding/#{payload}")
    end
    
    def add_pattern_binding(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:name, :key, :value])
      return @netscaler.adapter.post_no_body("config/policystringmap_pattern_binding/", "policystringmap_pattern_binding" => payload)
    end

    def remove_pattern_binding(payload)
      raise ArgumentError, 'payload cannot be null' if payload.nil?
      payload = Netscaler.hash_hack(payload)
      validate_payload(payload, [:policyStringMapPatternBindingName])
      return @netscaler.adapter.delete("config/policystringmap_pattern_binding/#{payload[:policyStringMapPatternBindingName]}")
    end
  end
end
