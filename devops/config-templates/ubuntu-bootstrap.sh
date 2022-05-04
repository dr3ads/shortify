#!/bin/bash

# Author: Daniel Alvarenga Lima
# Ubuntu version supported: 18.04 LTS 64Bit

# EXECUTE
# sudo chmod +x script-configure-ubuntu18.94-amd64.sh
# ./script-configure-ubuntu18.94-amd64.sh

#INSTRUCTIONS
# Change "true" por "false" to ignore software setup

# Required only in the first time to execute this script
UPDATE_REPOSITORIES=true
UPGRADE_PACKAGES=true


# build-essential, git, curl, libs
REQUIRED=true

CONFIGURE_GITHUB=false

CONFIGURE_GITLAB=false

# Add color for user, host, folder and git branch
COLORIZE_TERMINAL=false


JAVA_ORACLE_8U221_FROM_DOWNLOADS_FOLDER=false
# golang
GOLANG=false
GO_VERSION=1.12.7

# framework javascript
NODEJS=false

# ruby
RUBY_WITH_RVM=false
RUBY_WITH_RBENV=true # only install if RUBY_WITH_RVM is false
RUBY_WITHOUT_VERSION_MANAGER=false  # only install if RUBY_WITH_RVM and RUBY_WITH_RBENV is false
RUBY_VERSION=2.6.3
RUBY_VERSION_PATH=2.6

#rails
RAILS=false
RAILS_VERSION=5.2.3

# text editor
VIM=false

# visual studio code ide
VISUAL_STUDIO_CODE=false

# for files compression
COMPRESS_7ZIP=false

# image editor
GIMP=false

# player and codecs
VLC=false

# storage
DROPBOX=false

# qBitTorrent
TORRENT=false

# online musics
SPOTIFY=false

# terminal
TERMINATOR=false

# partitions manager
GPARTED=false

# gerenciador de particoes
POSTMAN=false

# messenger
SKYPE=false

# google chrome web browser
GOOGLE_CHROME=false

# database sqlite
SQLITE=false

# sqlite database manager
SQLITE_BROWSER=false

# database postgresql
POSTGRESQL=false

# postgresql database manager
PGADMIN=false

# database redis
REDIS=false

# redis database manager
REDIS_DESKTOP_MANAGER=false

# database mysql
MYSQL=false
MYSQL_USER=root
MYSQL_PASSWORD=root

# database manager mysql
WORKBENCH=false

# Install Tweaks to configure right click
# More details: https://itsfoss.com/fix-right-click-touchpad-ubuntu
RESOLVE_TOUCHPAD=false


# paths
LOG_SCRIPT=./log_script.txt
GITCONFIG=/etc/gitconfig
SSH_FOLDER=~/.ssh
SSHCONFIG="$SSH_FOLDER/config"
DOWNLOADS=~/Downloads
BASHRC=~/.bashrc
MOUSE_CONFIG=/usr/share/X11/xorg.conf.d/52-mymods.conf
RBENV_DIR=~/.rbenv
RUBY_BUILD_DIR="$RBENV_DIR/plugins/ruby-build"


function aptinstall {
    echo installing $1
    shift
    sudo apt-get -y -f install "$@" >$LOG_SCRIPT 2>$LOG_SCRIPT
}

function snapinstall {
    echo installing $1
    shift
    sudo snap install "$@" >$LOG_SCRIPT 2>$LOG_SCRIPT
}


if $UPDATE_REPOSITORIES
then
  echo "*** Update Respositories"
  sudo apt-get update
fi


if $UPGRADE_PACKAGES
then
  echo "*** Upgrade Packages"
  sudo apt-get -y upgrade
fi


if $REQUIRED
then
	aptinstall "Build Essencial" build-essential
	aptinstall Git git-core
	aptinstall CURL curl
	# aptinstall DevLibs zlib1g-dev libssl-dev libreadline-dev libyaml-dev libcurl4-openssl-dev libffi-dev python-software-properties
	# aptinstall "Nokogiri gem dependencies" libxml2 libxml2-dev libxslt1-dev
fi


if $JAVA_ORACLE_8U221_FROM_DOWNLOADS_FOLDER
then
	sudo apt-get -y remove --purge openjdk-*
	tar -xvf $DOWNLOADS/jdk-8u221-linux-x64.tar.gz
	sudo mkdir -p /usr/lib/jvm
	sudo mv $DOWNLOADS/jdk1.8.0_221 /usr/lib/jvm/
	sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_221/bin/java" 1
	sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_221/bin/javac" 1
	sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0_221/bin/javaws" 1
	sudo chmod a+x /usr/bin/java
	sudo chmod a+x /usr/bin/javac
	sudo chmod a+x /usr/bin/javaws
	sudo chown -R root:root /usr/lib/jvm/jdk1.8.0_221
	sudo update-alternatives --config java
	sudo update-alternatives --config javac
	sudo update-alternatives --config javaws
	java -version
fi


if $GOLANG
then
	echo "*** installing GOlang"
	GO_FILE=$DOWNLOADS/go$GO_VERSION.linux-amd64.tar.gz
	if [ -f $GO_FILE ]
	then
		echo ""
	else
		cd $DOWNLOADS
		wget https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz
	fi
	sudo tar -C /usr/local -xzf $GO_FILE
	echo '# Add GO lang path environment variable' >> $HOME/.profile
	echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile
	mkdir -p $HOME/go/src
fi


if $NODEJS
then
	snapinstall NodeJS node --channel=10/stable --classic
	node -v
fi


if $VIM
then
	aptinstall VIM vim
fi


if $VISUAL_STUDIO_CODE
then
	snapinstall "Visual Studio Code" code --classic
fi


if $COMPRESS_7ZIP
then
	aptinstall 7zip p7zip-full
	aptinstall "7zip rar extension" p7zip-rar
fi


if $GIMP
then
	aptinstall Gimp gimp
fi


if $VLC
then
	aptinstall VLC vlc
fi


if $DROPBOX
then
	aptinstall Dropbox nautilus-dropbox
fi


if $TORRENT
then
	aptinstall qBitTorrent qbittorrent
fi


if $SPOTIFY
then
	snapinstall Spotify spotify
fi


if $TERMINATOR
then
	aptinstall Terminator terminator
fi


if $GPARTED
then
	aptinstall GParted gparted
fi


if $POSTMAN
then
	snapinstall Postman postman
fi


if $SKYPE
then
	snapinstall Skype skype --classic
fi


if $GOOGLE_CHROME
then
	echo "*** installing Google Chrome 64bits"
	CHROME_FILE=$DOWNLOADS/google-chrome-stable_current_amd64.deb
	if [ -f $CHROME_FILE ]
	then
		echo ""
	else
		cd $DOWNLOADS
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	fi
	sudo dpkg -i $CHROME_FILE
fi


if $SQLITE
then
	aptinstall SQLite sqlite3 libsqlite3-dev
fi


if $SQLITE_BROWSER
then
	aptinstall "SQLite Browser" sqlitebrowser
fi


if $POSTGRESQL
then
	aptinstall PostgreSQL postgresql postgresql-contrib libpq-dev
fi


if $PGADMIN
then
	aptinstall "PG Admin" pgadmin3
fi


if $MYSQL
then
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_USER"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD"
aptinstall MySQL mysql-server mysql-client libmysqlclient-dev
mysql -uroot -proot <<SQL
CREATE USER 'rails'@'localhost';
CREATE DATABASE activerecord_unittest  DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE DATABASE activerecord_unittest2 DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON activerecord_unittest.* to 'rails'@'localhost';
GRANT ALL PRIVILEGES ON activerecord_unittest2.* to 'rails'@'localhost';
GRANT ALL PRIVILEGES ON inexistent_activerecord_unittest.* to 'rails'@'localhost';
SQL
fi


if $WORKBENCH
then
	echo "*** installing Workbench"
	aptinstall "Workbench dependeencies" libctemplate2v5 libgeos-3.5.0 libgeos-c1v5 libhdf4-0-alt libaec0 libsz2 libhdf5-10 libnetcdf11 libpcrecpp0v5 libpq5 libtinyxml2.6.2v5 libzip4 python-crypto python-six python-ecdsa python-paramiko
	WORKBENCH_FILE=$DOWNLOADS/mysql-workbench-community-6.3.8-1ubu1604-amd64.deb
	if [ -f $WORKBENCH_FILE ]
	then
		echo ""
	else
		cd $DOWNLOADS
		wget https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.3.8-1ubu1604-amd64.deb
	fi
	sudo dpkg -i $WORKBENCH_FILE
fi



if $RUBY_WITH_RVM
then
	echo "installing RVM with RUBY $RUBY_VERSION"
	if ! type rvm >$LOG_SCRIPT 2>$LOG_SCRIPT; then
		cd
		gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
		aptinstall "RVM dependencies" gawk libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
		curl -sSL https://get.rvm.io | bash -s stable
		source ~/.rvm/scripts/rvm
	fi
	rvm requirements
	rvm install $RUBY_VERSION
	rvm use $RUBY_VERSION --default

	echo installing Bundler
	echo "gem: --no-ri --no-rdoc" > ~/.gemrc
	gem install bundler -N >$LOG_SCRIPT 2>$LOG_SCRIPT


elif $RUBY_WITH_RBENV
then
	echo "installing Rbenv with Ruby $RUBY_VERSION"
	aptinstall "Rbenv dependencies" autoconf bison libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev
	if [ -d $RBENV_DIR ]
	then
		cd $RBENV_DIR
		git pull
	else
		git clone https://github.com/rbenv/rbenv.git $RBENV_DIR
		echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
		echo 'eval "$(rbenv init -)"' >> ~/.bashrc
		export PATH="$HOME/.rbenv/bin:$PATH"
		eval "$(rbenv init -)"
	fi
	if [ -d $RUBY_BUILD_DIR ]
	then
		cd $RUBY_BUILD_DIR
		git pull
	else
		git clone https://github.com/rbenv/ruby-build.git $RUBY_BUILD_DIR
		echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
		export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
		cd $RUBY_BUILD_DIR
		./install.sh
	fi
	source ~/.bashrc
	rbenv install $RUBY_VERSION -s
	rbenv global $RUBY_VERSION

	echo installing Bundler
	echo "gem: --no-ri --no-rdoc" > ~/.gemrc
	gem install bundler -N >$LOG_SCRIPT 2>$LOG_SCRIPT


elif $RUBY_WITHOUT_VERSION_MANAGER
then
	snapinstall ruby --classic --channel=$RUBY_VERSION_PATH/stable

	echo installing Bundler
	echo "gem: --no-ri --no-rdoc" > ~/.gemrc
	gem install bundler -N >$LOG_SCRIPT 2>$LOG_SCRIPT
fi


if $RAILS
then
	echo "installing Rails $RAILS_VERSION"
	gem install rails -v $RAILS_VERSION -N >$LOG_SCRIPT 2>$LOG_SCRIPT
fi


if $REDIS
then
	aptinstall Redis redis-server
fi


if $REDIS_DESKTOP_MANAGER
then
	snapinstall "Redis Desktop Manager" redis-desktop-manager
fi


if $RESOLVE_TOUCHPAD
then
  aptinstall Tweaks gnome-tweaks
fi


if $COLORIZE_TERMINAL
then
	echo -e "function parse_git_branch () {" >> $BASHRC
	echo -e "  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'" >> $BASHRC
	echo -e "}" >> $BASHRC
	echo -e 'RED="\[\033[01;31m\]"' >> $BASHRC
	echo -e 'YELLOW="\[\033[01;33m\]"' >> $BASHRC
	echo -e 'GREEN="\[\033[01;32m\]"' >> $BASHRC
	echo -e 'BLUE="\[\033[01;34m\]"' >> $BASHRC
	echo -e 'NO_COLOR="\[\033[00m\]"' >> $BASHRC
	echo -e 'PS1="$GREEN\u@\h$NO_COLOR:$BLUE\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "' >> $BASHRC
	source $BASHRC
fi


echo "*** remove packages"
sudo apt-get clean


if $CONFIGURE_GITHUB
then
  sudo rm $GITCONFIG
  sudo touch $GITCONFIG
  sudo chmod 777 $GITCONFIG
  echo -e "[user]" >> $GITCONFIG
  echo -e "  name = $GITHUB_NAME" >> $GITCONFIG
  echo -e "  email = $GITHUB_MAIL" >> $GITCONFIG
  echo -e "[core]" >> $GITCONFIG
  echo -e "  editor = vim -f" >> $GITCONFIG
  echo -e "[alias]" >> $GITCONFIG
  echo -e "  df = diff" >> $GITCONFIG
  echo -e "  st = status" >> $GITCONFIG
  echo -e "  cm = commit" >> $GITCONFIG
  echo -e "  ch = checkout" >> $GITCONFIG
  echo -e "  br = branch" >> $GITCONFIG
  echo -e "  lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative" >> $GITCONFIG
  echo -e "    ctags = !.git/hooks/ctags" >> $GITCONFIG
  echo -e "[color]" >> $GITCONFIG
  echo -e "  branch = auto" >> $GITCONFIG
  echo -e "  diff = auto" >> $GITCONFIG
  echo -e "  grep = auto" >> $GITCONFIG
  echo -e "  interactive = auto" >> $GITCONFIG
  echo -e "  status = auto" >> $GITCONFIG
  echo -e "  ui = 1" >> $GITCONFIG
  echo -e "[branch]" >> $GITCONFIG
  echo -e "  autosetuprebase = always" >> $GITCONFIG
  echo -e "[github]" >> $GITCONFIG
  echo -e "  user = $GITHUB_USER" >> $GITCONFIG

  ssh-keygen -t rsa -b 4096 -C "$GITHUB_MAIL" -N "" -f $SSH_FOLDER/id_rsa_github
	echo ""
	echo ""
	echo "**********************"
	echo "CONFIGURE GIT USER"
	echo ""
	echo "Adicione a public ssh key em 'https://github.com/settings/ssh':"
	echo ""
	cat $SSH_FOLDER/id_rsa_github.pub
	echo ""
	echo "**********************"
	
  touch $SSHCONFIG
  echo -e "#Github (default)" >> $SSHCONFIG
  echo -e "  Host github" >> $SSHCONFIG
  echo -e "  HostName github.com" >> $SSHCONFIG
  echo -e "  User git" >> $SSHCONFIG
  echo -e "  IdentityFile $SSH_FOLDER/id_rsa_github" >> $SSHCONFIG
fi

if $CONFIGURE_GITLAB
then
  ssh-keygen -t rsa -b 4096 -C "$GITLAB_MAIL" -N "" -f $SSH_FOLDER/id_rsa_gitlab
	echo ""
	echo ""
	echo "**********************"
	echo "CONFIGURE GITLAB USER"
	echo ""
	echo "Adicione a public ssh key ao GitLab:"
	echo ""
	cat $SSH_FOLDER/id_rsa_gitlab.pub
	echo ""
	echo "**********************"

  touch $SSHCONFIG
  echo -e "#Gitlab" >> $SSHCONFIG
  echo -e "  Host gitlab" >> $SSHCONFIG
  echo -e "  HostName $GITLAB_HOSTNAME" >> $SSHCONFIG
  echo -e "  User git" >> $SSHCONFIG
  echo -e "  IdentityFile $SSH_FOLDER/id_rsa_gitlab" >> $SSHCONFIG
fi


if $POSTGRESQL
then
	echo ""
	echo ""
	echo "**********************"
	echo "CONFIGURE O POSTGRES"
	echo ""
	echo "Para definir usuário e senha no PostgreSQL, execute manualmente os seguintes comandos:"
	echo "sudo -u postgres createuser NOME_DO_USUARIO -s"
	echo "sudo -u postgres psql"
	echo "\password NOME_DO_USUARIO"
	echo "**********************"
fi

//swap
echo "Make swap"
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo sysctl vm.swappiness=10
sudo sysctl vm.vfs_cache_pressure=50


//docker
echo "Docker"
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt -y install docker-ce
sudo usermod -aG docker ${USER}
sudo apt  -y install docker-compose
exit