VAGRANT_API_VERSION = 2

Vagrant.configure(VAGRANT_API_VERSION) do |config|
  #config.vm.box = 'ubuntu/xenial64'
  config.vm.box = 'ubuntu/trusty64'
  config.vm.box_check_update = false

  config.ssh.forward_agent = true

  config.vm.network "private_network", ip: "10.2.0.10", netmask: "255.255.0.0"
  #config.vm.network 'private_network', type: 'dhcp'
  #config.vm.network 'private_network', ip: "192.168.50.4"

  #config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder '~/code/', '/vagrant', type: 'nfs'
  #config.vm.synced_folder '~/.dotfiles/', '/home/vagrant/.dotfiles', type: 'nfs'

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"] # for dnsdock
    vb.memory = '4096'
    vb.gui = true
  end

  #[3000, 80].each do |port|
    #config.vm.network "forwarded_port", guest: port, host: port
  #end

  #config.vm.provision 'dotfiles-fetch', type: 'shell' do |shell|
    #shell.privileged = false
    #shell.inline = <<-SHELL
      #sudo apt-get update
      #sudo apt-get install -y git
      #mkdir -p ~/.ssh
      #chmod 700 ~/.ssh
      #ssh-keyscan -H github.com >> ~/.ssh/known_hosts
      #ssh -T git@github.com
      #git clone https://github.com/artofhuman/dotfiles.git ~/.dotfiles
    #SHELL
  #end

  config.vm.provision 'ansible_local' do |ansible|
    ansible.playbook = '/home/vagrant/.dotfiles/playbook.yml'
    ansible.tags = ENV['TAGS']
  end
end
