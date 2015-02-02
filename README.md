# Shoobx Vagrant
Shoobx Vagrant Setup

This documentation is still a work in progress so please ping me with questions.
If you want to contribute I can add you to the repo as well.

To use this download vagrant [here](https://www.vagrantup.com/).
Then download virtual box [here](https://www.virtualbox.org/).

Once both are installed cd into this repo.

There are a number of file locaitons defined at the top of the Vagrantfile.
These will probably need to be updated for your setup.
In the Vagrantfile update the location of your git checkout of your src tree.

You will probably want to adjust your ssh key locations as well.
More than likely the key is just ~/.ssh/id_rsa.
These files will be copied to the new guest system.

Run the command: vagrant up
It will probably take a while.
Once it is up run the command: vagrant ssh

Once you are in I've also added a script to add your ssh to the ssh agent.
Again you may need to edit to point to your key. My key is called shoobx_rsa.
To run it do: sh add_ssh_keys.sh
You should be prompted to enter your key passphrase.

Now cd into your repo. It will be under /opt/shobox/shoobx.app.
You may need to run make clean first.
Then run make ubuntu-environment.
Then run make.
Then run bin/console initialize.

After that you should be able to run: make run

Everything should be accesible on [http://localhost:8080](http://localhost:8080) in the browser on the host machine.

If you want to try zsh I also added a script to set that up.

Just run: 
sh setup_zsh.sh

Again ping me with any questions and good luck!


