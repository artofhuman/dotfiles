VAGRANT_API_VERSION = 2

Vagrant.configure(VAGRANT_API_VERSION) do |config|
  #config.vm.box = 'ubuntu/xenial64'
  config.vm.box = 'ubuntu/trusty64'
  config.vm.box_check_update = false

  config.ssh.forward_agent = true

  config.vm.network 'private_network', type: 'dhcp'

  #config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder '~/code/', '/vagrant', type: 'nfs'
  #config.vm.synced_folder '~/.dotfiles/', '/home/vagrant/.dotfiles', type: 'nfs'

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '2048'
  end

  config.vm.provision 'dotfiles-fetch', type: 'shell' do |shell|
    shell.privileged = false
    shell.inline = <<-SHELL
      sudo apt-get update
      sudo apt-get install -y git
      mkdir -p ~/.ssh
      chmod 700 ~/.ssh
      ssh-keyscan -H github.com >> ~/.ssh/known_hosts
      ssh -T git@github.com
      git clone git@github.com:justcxx/dotfiles.git ~/.dotfiles
    SHELL
  end

  config.vm.provision 'ansible_local' do |ansible|
    ansible.playbook = '/home/vagrant/.dotfiles/playbook.yml'
    ansible.tags = ENV['TAGS']
  end
end
