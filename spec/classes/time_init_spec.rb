require 'spec_helper'
 
describe 'time', :type => :class do

  let(:facts) { {:interfaces => 'eth0'} }

  it { should create_class('time') }
  it { should contain_package('tzdata') }
  it { should contain_package('ntp') }
  it { should contain_service('ntpd').with(
    'ensure'  => 'running',
    'enable'  => 'true'
  ) }

  # Config
  it { should contain_file('/etc/localtime').with(
    'ensure'  => 'link',
    'target'  => '/usr/share/zoneinfo/UTC'
  ) }
  it { should contain_file('/etc/sysconfig/clock') }
  it { should contain_file('/etc/ntp.conf') }

  it { should contain_common__line('peerntp-eth0-y').with_ensure('absent') }
  it { should contain_common__line('peerntp-eth0-n') }

  context "when ::eth1 not in ::interfaces" do
    it { should_not contain_common__line('peerntp-eth1-y') }
    it { should_not contain_common__line('peerntp-eth1-n') }
  end
  
  context "when ::eth1 in ::interfaces" do
    let(:facts) { {:interfaces => 'eth0, eth1'} } 
    it { should contain_common__line('peerntp-eth1-y') }
    it { should contain_common__line('peerntp-eth1-n') }
  end

end
