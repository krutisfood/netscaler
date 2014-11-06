require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::ServiceGroup do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when showing servicegroups' do
    it "with no param used return all service groups" do
      result = connection.servicegroups.show
      result.should be_kind_of(Hash)
    end

    it 'supplying the name parameter will return Hash' do
      result = connection.servicegroups.show :name => 'foo'
      result.should be_kind_of(Hash)
    end

    it 'when showing a particular service group string is invalid' do
      expect {
        connection.servicegroups.show('asdf')
      }.should raise_error(TypeError, /convert/)
    end

    it 'when showing a particular service group :name is required' do
      expect {
        connection.servicegroups.show(:foo => 'bar')
      }.should raise_error(ArgumentError, /name/)
    end
  end

  context 'when adding a new servicegroup' do

    it 'a name is required' do
      #netscaler.adapter = Netscaler::MockAdapter.new :status_code=>400, :body => '{ "errorcode": 1095, "message": "Required argument missing [name]", "severity": "ERROR" }',

      expect {
        connection.servicegroups.add_servicegroup({ 'serviceType' => 'tcp' })
      }.should raise_error(ArgumentError, /serviceGroupName/)
    end

    it 'a service type is required' do
      expect {
        connection.servicegroups.add_servicegroup({ 'serviceGroupName' => 'test-serviceGroup' })
      }.should raise_error(ArgumentError, /serviceType/)
    end

  end

  context 'when binding a new lbmonitor to servicegroup' do

    it 'a Service group name is required' do
      expect {
        connection.servicegroups.lbmonitor_servicegroup_binding({ 'monitorName' => 'TCP' })
      }.should raise_error(ArgumentError, /serviceGroupName/)
    end

    it 'a lbmonitor name is required' do
      expect {
        connection.servicegroups.lbmonitor_servicegroup_binding({ 'serviceGroupName' => 'test-serviceGroup' })
      }.should raise_error(ArgumentError, /monitorName/)
    end

  end

  context 'when unbinding a lbmonitor from servicegroup' do

    it 'a Service group name is required' do
      expect {
        connection.servicegroups.lbmonitor_servicegroup_binding({ 'monitorName' => 'TCP' })
      }.should raise_error(ArgumentError, /serviceGroupName/)
    end

    it 'a lbmonitor name is required' do
      expect {
        connection.servicegroups.lbmonitor_servicegroup_binding({ 'serviceGroupName' => 'test-serviceGroup' })
      }.should raise_error(ArgumentError, /monitorName/)
    end

  end
  
  context 'when binding a new server to servicegroup' do

    it 'a Service group name is required' do
      expect {
        connection.servicegroups.bind_servicegroup_servicegroupmember({ 'port'=> '8080', 'ip' => '199.199.199.199' })
      }.should raise_error(ArgumentError, /serviceGroupName/)
    end

    it 'a server entity is required' do
      expect {
        connection.servicegroups.bind_servicegroup_servicegroupmember({ 'serviceGroupName' => 'test-serviceGroup', 'port' => '8080' })
      }.should raise_error(ArgumentError, /serverName/)
    end

    it 'a port is required' do
      expect {
        connection.servicegroups.bind_servicegroup_servicegroupmember({ 'serviceGroupName' => 'test-serviceGroup', 'ip' => '199.199.199.199' })
      }.should raise_error(ArgumentError, /port/)
    end

  end

  context 'when unbinding a server from servicegroup' do

    it 'a Service group name is required' do
      expect {
        connection.servicegroups.unbind_servicegroup_servicegroupmember({ 'port' => '8080', 'ip' => '199.199.199.199' })
      }.should raise_error(ArgumentError, /serviceGroupName/)
    end

    it 'a server entity is required' do
      expect {
        connection.servicegroups.unbind_servicegroup_servicegroupmember({ 'serviceGroupName' => 'test-serviceGroup', 'port' => '8080' })
      }.should raise_error(ArgumentError, /serverName/)
    end

    it 'a port is required' do
      expect {
        connection.servicegroups.unbind_servicegroup_servicegroupmember({ 'serviceGroupName' => 'test-serviceGroup', 'ip' => '199.199.199.199' })
      }.should raise_error(ArgumentError, /port/)
    end

  end
  
end
