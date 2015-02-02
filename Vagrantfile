VAGRANTFILE_API_VERSION = "2"
HOME_DIR = "/Users/ndurell/"
LOCAL_SRC_DIR = HOME_DIR + "work/shoobx.app"
SSH_DIR = ".ssh"
SSH_HOME_DIR = "~/" + SSH_DIR + "/"
SSH_PRIVATE_KEY = SSH_HOME_DIR + "shoobx_rsa"
SSH_PUBLIC_KEY = SSH_HOME_DIR + "shoobx_rsa.pub"
SSH_CONFIG = SSH_HOME_DIR + "config"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "larryli/vivid64"

  config.vm.provider "virtualbox" do |v|
    host = RbConfig::CONFIG['host_os']

    # Give VM 1/4 system memory & access to all cpu cores on the host
    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i
      # meminfo shows KB and we need to convert to MB
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    else # sorry Windows folks, I can't help you
      cpus = 2
      mem = 1024
    end

    v.customize ["modifyvm", :id, "--memory", mem]
    v.customize ["modifyvm", :id, "--cpus", cpus]
  end

  # forward port for http server
  config.vm.network "forwarded_port", 
    guest: 8080, host: 8080

  config.vm.synced_folder LOCAL_SRC_DIR, "/opt/shoobx/shoobx.app",
    type: "nfs"

  config.vm.network "private_network", type: "dhcp"

  config.vm.provision "shell",
    path: "provision.sh"

  # copy ssh keys and configs
  config.vm.provision "file", source: SSH_PRIVATE_KEY, 
    destination: SSH_PRIVATE_KEY
  config.vm.provision "file", source: SSH_PUBLIC_KEY, 
    destination: SSH_PUBLIC_KEY
  config.vm.provision "file", source: SSH_CONFIG,
    destination: SSH_CONFIG

  # copy git config
  config.vm.provision "file", source: "~/.gitconfig", 
    destination: ".gitconfig"

  # a simple script to add your keys to the ssh agent
  config.vm.provision "file", source: "add_ssh_keys.sh",
    destination: "add_ssh_keys.sh"

  # a simple script to add your keys to the ssh agent
  config.vm.provision "file", source: "setup_zsh.sh",
    destination: "setup_zsh.sh"

end