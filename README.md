Install GPG keys

As a first step install GPG keys used to verify installation package:
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB


Installation
I recommend you read the installation script yourself. This will give you a chance to understand what it is doing before installing, and allow you to feel more comfortable running it if you do so.

∞1. Download and run the RVM installation script
Installing the stable release version:

\curl -sSL https://get.rvm.io | bash -s stable
To get the latest development state:

\curl -sSL https://get.rvm.io | bash
Instruct RVM to not change the shell initializations files 'rc' / 'profile':

\curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
Please note that from this point it is user responsibility to add sourcing rvm to appropriate files.

For a Multi-User install you would execute the following:

\curl -sSL https://get.rvm.io | sudo bash -s stable
Note: The Multi-User install instructions must be prefixed with the  sudo command. However, once the install is complete, and the instructions to add users to the  rvm group is followed, the use of either sudo or rvmsudo is no longer required. The sudo command is only to temporarily elevate privileges so the installer can complete its work. If you need to use sudo or rvmsudo after the install is complete, some part of the install directions were not properly followed. This usually is because people execute the install as root, rather than executing the installation instructions from a non-privileged user account.

Installing a specific version:

\curl -sSL https://get.rvm.io | bash -s -- --version latest
\curl -sSL https://get.rvm.io | bash -s -- --branch [owner/][repo]
Prefix the 'bash' portion with 'sudo', of course, if you wish to apply this to a Multi_user Install. Please feel free to check out our upgrading docs for more details on branch format.

Debugging installation process:

\curl -sSL https://get.rvm.io | bash -s -- --trace
If the rvm install script complains about certificates you need to follow the displayed instructions.

Single-User Install Location: ~/.rvm/
If the install script is run as a standard, non-root user, RVM will install into the current users's home directory.

Modification of user configuration files (*rc / *profile) - RVM by default will modify user startup files, although it is not recommended you can disable automated process and do this manually:

\curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
echo "source $HOME/.rvm/scripts/rvm" >> ~/.bash_profile
Multi-User Install Location: /usr/local/rvm
If the install script is run prefixed with sudo, RVM will automatically install into /usr/local/rvm. Please see the troubleshooting page for an important note regarding Multi-User Installs.

Please see the FAQ page for an important note regarding root only installs.

External tutorials
Note that that any outside tutorials are NOT supported whether they work or not. Tutorials are great, however we have spent massive amounts of man hours debugging the installation process. Please use the install process(es) from this site only, as this is the only supported installation types and methods.

To update an existing RVM installation
It is safe to simply re-run the installation script again, or you can follow the upgrading docs.

∞2. Load RVM into your shell sessions as a function
Single-User:
The rvm function will be automatically configured for every user on the system if you install as single user. Read the output of installer to check which files were modified.

Multi-User:
The rvm function will be automatically configured for every user on the system if you install with sudo. This is accomplished by loading /etc/profile.d/rvm.sh on login. Most Linux distributions default to parsing /etc/profile which contains the logic to load all files residing in the /etc/profile.d/ directory. Once you have added the users you want to be able to use RVM to the rvm group, those users MUST log out and back in to gain rvm group membership because group memberships are only evaluated by the operating system at initial login time. Zsh not always sources /etc/profile so you might need to add this in /etc/**/zprofile:

source /etc/profile

Mixed mode (user gemsets):
After following above instructions for Multi-User.
Select a user as a manager - he will be responsible for installing new rubies. This user should never run the command introduced below. If this happens, remove/rename the ${HOME}/.rvmrc, logout and then relogin. Otherwise you won't be able to install/upgrade new rubies correctly.
For each user that want to use RVM, an additional command needs to be run (once) for each user:

  rvm user gemsets
Gemsets created by these users will be hosted in their HOME directory. It's not possible to use global gemsets from system without using tricks like manually linking directories and they should not be used in mixed-mode. Please bear in mind that 'system' in this context does not refer to your distribution's ruby packages, but to the RVM Multi-User installation.

You have two possibilities to manage RVM. The first one is to add managers to the rvm group. The second one is to use separate managers with rvmsudo and privilege escalation. Note that it is not safe to use  rvmsudo from mixed mode user. Both can be mixed without any side-effect. It is however very important to not enable mixed-mode gemsets or rubies for the managers. RVM is using a custom umask (umask u=rwx,g=rwx,o=rx) when installing gemsets, rubies, updating itself, etc. This should not impact your system. But if you prefer to avoid RVM messing around with your umask, you can comment the umask line in /etc/rvmrc.

This mode should also works with passenger, please follow passenger instructions. .

∞3. Reload shell configuration & test
Close out your current shell or terminal session and open a new one (preferred). You may load RVM with the following command:

source ~/.rvm/scripts/rvm
If installation and configuration were successful, RVM should now load whenever you open a new shell. This can be tested by executing the following command which should output rvm is a function as shown below.

type rvm | head -n 1
rvm is a function
NOTE: Before reporting problems check rvm notes as it might contain important information.

Congratulations! You have successfully installed RVM.
∞Try out your new RVM installation
Below are some examples of how to install and use a Ruby under RVM.

Display a list of all known rubies. NOTE: RVM can install many more Rubies not listed.

rvm list known
# MRI Rubies
[ruby-]1.8.6[-p420]
[ruby-]1.8.7[-p374]
[ruby-]1.9.1[-p431]
[ruby-]1.9.2[-p320]
[ruby-]1.9.3[-p545]
[ruby-]2.0.0-p353
[ruby-]2.0.0[-p451]
[ruby-]2.1[.1]
[ruby-]2.1-head
ruby-head
...
Install a version of Ruby (eg 2.1.1):

rvm install 2.1
Checking requirements for opensuse.
Requirements installation successful.
Installing Ruby from source to: /home/mpapis/.rvm/rubies/ruby-2.1.1, this may take a while depending on your cpu(s)...
...
Install of ruby-2.1.1 - #complete
Using /home/mpapis/.rvm/gems/ruby-2.1.1
Use the newly installed Ruby:

rvm use 2.1
Using /home/mpapis/.rvm/gems/ruby-2.1.1
Check this worked correctly:

ruby -v
ruby 2.1.1p76 (2014-02-24 revision 45161) [x86_64-linux]

which ruby
/home/mpapis/.rvm/rubies/ruby-2.1.1/bin/ruby
Optionally, you can set a version of Ruby to use as the default for new shells. Note that this overrides the 'system' ruby:

rvm use 2.1 --default



