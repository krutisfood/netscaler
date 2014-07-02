require 'netscaler/netscaler_service'
require 'netscaler/policy/stringmap'

module Netscaler
  class Policy < NetscalerService
    def initialize(netscaler)
      @netscaler = netscaler

      @stringmaps = StringMap.new netscaler
    end

    def stringmaps
      @stringmaps
    end
  end
end
