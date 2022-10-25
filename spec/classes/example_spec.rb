require 'spec_helper'

describe 'jupyterhub' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'jupyterhub class without any parameters' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('jupyterhub::params') }
          it { is_expected.to contain_class('jupyterhub::install').that_comes_before('jupyterhub::config') }
          it { is_expected.to contain_class('jupyterhub::config') }
          it { is_expected.to contain_class('jupyterhub::service').that_subscribes_to('jupyterhub::config') }

          it { is_expected.to contain_service('jupyterhub') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'jupyterhub class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          osfamily: 'Solaris',
          operatingsystem: 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_service('jupyterhub') }.to raise_error(Puppet::Error, %r{Nexenta not supported}) }
    end
  end
end
