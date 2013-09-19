require 'spec_helper_system'

describe 'basic tests:' do
  context 'make sure we have copied the module across' do
    # No point diagnosing any more if the module wasn't copied properly
    context shell  'ls /etc/puppet/modules/time' do
      its(:stdout) { should =~ /Modulefile/ }
      its(:stderr) { should be_empty }
      its(:exit_code) { should be_zero }
    end
  end


#class { 'puppetdb::master::config': }
#      EOS
#    end
#
#    it 'make sure it runs without error' do
#      system_run('puppet module install puppetlabs/stdlib')
#      system_run('puppet module install puppetlabs/postgresql')
#      system_run('puppet module install puppetlabs/firewall')
#      system_run('puppet module install cprice404/inifile')
#
#      puppet_apply(pp) do |r|
#        r[:exit_code].should_not eq(1)
#      end
#    end
#
#    it 'should be idempotent' do
#      puppet_apply(:code => pp, :debug => true) do |r|
#        r[:exit_code].should == 0
#      end
#    end
#  end
#
#  describe 'enabling report processor' do
#    let(:pp) do
#      pp = <<-EOS
#class { 'puppetdb::master::config':
#  manage_report_processor => true,
#  enable_reports => true
#}
#      EOS
#    end
#
#    it 'should add the puppetdb report processor to puppet.conf' do
#      puppet_apply(pp) do |r|
#        r[:exit_code].should_not eq(1)
#      end
#
#      system_run("cat /etc/puppet/puppet.conf") do |r|
#        r[:stdout].should =~ /^reports\s*=\s*([^,]+,)*puppetdb(,[^,]+)*$/
#      end
#    end
#
#  end

end
