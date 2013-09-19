require 'spec_helper_system'

describe "time class:" do
  context 'should run successfully and be idempotent' do
    pp = "class { 'time': }"

    context puppet_apply(pp) do
      its(:stderr) { should be_empty }
      its(:exit_code) { should_not == 1 }
      its(:refresh) { should be_nil }
      its(:stderr) { should be_empty }
      its(:exit_code) { should be_zero }
    end
  end

  context 'should create localtime symlink' do
    describe file('/etc/localtime') do
      it { should be_linked_to('/usr/share/zoneinfo/UTC') }
    end
  end

  context 'enable => false:' do
    pp = "class { 'time': timezone => 'America/Denver' }"

    context puppet_apply(pp) do
      its(:stderr) { should be_empty }
      its(:exit_code) { should_not == 1 }
      its(:refresh) { should be_nil }
      its(:stderr) { should be_empty }
      its(:exit_code) { should be_zero }

    end

    describe file('/etc/localtime') do
      it { should be_linked_to('/usr/share/zoneinfo/America/Denver') }
    end
  end

end
