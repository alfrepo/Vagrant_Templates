

RHOME="/root"
MYUSER="vagrant"
VHOME="/home/$MYUSER"
ISWSL="true"
GITDOMAIN="code.YOURDOMAIN.com"


##################################################################################################################################
#WSL specific code


# if in Windows Subsystem for Linux - WSL
if [ "$ISWSL" == "true" ]
then

	cp "/mnt/d/Documents/gitlab.ppk" $VHOME/.ssh/
	chown $MYUSER:$MYUSER $VHOME/.ssh/gitlab.ppk
	chmod 700 $VHOME/.ssh/gitlab.ppk

	# add git authentication
	git config --global user.name "user.surname"
	git config --global user.email "user.surname@mail.com"
	git config -l

	echo -e "Host $GITDOMAIN\n \t  IdentityFile $VHOME/.ssh/gitlab.ppk" > $VHOME/.ssh/config

fi




##################################################################################################################################
##################################################################################################################################



# set the time zone
sudo timedatectl set-timezone Europe/Berlin


# update
apt-get update -y






##################################################################################################################################
##################################################################################################################################




# TOOLS WITHOUT CONFIGURATION


# install zip
apt-get install -y zip

# unzip
apt-get install -y unzip


# tool for decoding jwt tokens
npm install -g jwt-cli

# CDK cloud development toolkit
npm install -g aws-cdk


# tool for reading JSON in console
apt-get install -y jq


# no sdkman installer
# go
apt-get install -y golang-go


##################################################################################################################################
# SDKs


# install sdkman 
curl -fsSL "https://get.sdkman.io?rcupdate=false" | bash

# add to path in current session
source ~/.sdkman/bin/sdkman-init.sh

# adding sdkman to the path
echo "source ~/.sdkman/bin/sdkman-init.sh" >> ~/.bashrc


# gradle
sdk install gradle 8.4  < /dev/null

# maven
sdk install maven < /dev/null

# springboot
sdk install springboot 3.1.5 < /dev/null


# java open GraalVM from liberica "native image kit"
sdk install java 22.2.r17-nik < /dev/null

# java openjdk
sdk install java 19.0.2-open < /dev/null







##################################################################################################################################
##################################################################################################################################



# font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip -O $VHOME/Meslo.zip
mkdir -p $VHOME/.fonts
unzip $VHOME/Meslo.zip -d $VHOME/.fonts
sudo apt-get install -y  fontconfig
fc-cache -fv




# brew
apt-get install -y linuxbrew-wrapper

# refresh session
su - $USER













# NODE
NODE_MAJOR_VERSION="20"



## SCRIPT DEPRECATION WARNING
# node.js
# add a source file for the official Node.js LTS repo, grab the signing key and will run apt update
# curl -sL https://deb.nodesource.com/setup_${NODE_MAJOR_VERSION}.x | sudo -E bash -
# sudo apt-get install -y nodejs


# switch 
apt-get install -y ca-certificates curl gnupg
mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg


echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR_VERSION.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs -y








# PYPTHON

# apg - generates passwords
apt-get install -y apg


# pip
apt-get install -y python3-pip

# poetry
curl -sSL https://install.python-poetry.org | python3 -

# refresh session
su - $USER


# pip upgrade and set home directory current user
sudo -H pip3 install --upgrade pip

# refresh session
su - $USER


# awscli
pip3 install awscli


# for some reason only the installation for a user works fine.
# sam https://itnext.io/creating-aws-lambda-applications-with-sam-dd13258c16dd
# install sam for the user "$MYUSER"
sudo -H -u $MYUSER bash -c 'pip3 install --user aws-sam-cli'

# install sam for the user "root"
sudo pip3 install --user aws-sam-cli

# adding to the path
sudo echo "PATH=$RHOME/.local/bin:$PATH" >> $RHOME/.bashrc
sudo echo "PATH=$VHOME/.local/bin:$PATH" >> $VHOME/.bashrc




# jinja2 for cli
pip3 install j2cli
pip3 install j2cli[yaml]




# terraform or ansible require an upgrade
pip3 install --upgrade cryptography


# refresh session
su - $USER




# GRADLE

# gradle proxy configuration
mkdir -p $RHOME/.gradle/
touch $RHOME/.gradle/gradle.properties



cp -rf $RHOME/.gradle $VHOME/
chown -R $USER:$USER $VHOME/.gradle









# GIT

# add git authentication
git config --global user.name "user.name"
git config --global user.email "user.name@privategitlabrepo.com"
git config -l

cp $RHOME/.gitconfig $VHOME/
chown $USER:$USER $VHOME/.gitconfig


#### add code.privategitlabrepo.com to the known_hosts
# ssh-keyscan code.privategitlabrepo.com >> $VHOME/.ssh/known_hosts

# the rights of the gitlab.key should be restricted to the $MYUSER used
sudo chown -R $USER:$USER $VHOME/.ssh
sudo chmod -R 700 $VHOME/.ssh


# add a default gitattribute to prevent line conversion
echo -e "# Handle line endings automatically for files detected as text\n* text=auto\n\n# Never modify line endings of our bash scripts\n*.sh -crlf\n\n# The above will handle all files NOT found below\n*.*     binary" > /etc/gitattributes





# ANSIBLE - configure some example hosts for ansible

mkdir -p /etc/ansible/
touch  /etc/ansible/hosts
touch  /etc/ansible/ansible.cfg


# sudo apt-add-repository -y ppa:ansible/ansible
# sudo apt-get -y update
# sudo apt-get -y install ansible

echo -e "[local]\n127.0.0.1   ansible_connection=local \n" >> /etc/ansible/hosts # add hosts

# use the ec2key.priv.openssh.ppk, which is the default key for Ec2 machines on the example project
echo -e "[aws]\n52.17.66.234 ansible_user=ubuntu ansible_ssh_private_key_file=$VHOME/.ssh/ec2key.priv.openssh.ppk\n" >> /etc/ansible/hosts # add hosts
sed -i 's/.*pipelining = False.*/pipelining = True/' /etc/ansible/ansible.cfg # reconfigure ansible
sed -i 's/.*allow_world_readable_tmpfiles.*/allow_world_readable_tmpfiles= True/' /etc/ansible/ansible.cfg
sed -i 's/.*retry_files_enabled =.*/retry_files_enabled = False/' /etc/ansible/ansible.cfg

# ansible
# IAC reqruies ansible >= Version 2.4
sudo python3 -m pip install --user ansible







# TERRAFORM
apt-get install -y unzip

TERRAFORM_VERSION=1.6.2

wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv -f terraform /usr/local/bin/








#########################################
#########################################
#########################################

# From here only if in Vagrant evnrionment

#########################################

if id "vagrant" &>/dev/null; then
	    echo 'Assume you are running in a VM, so installing the VM tools'
    else
	        echo 'Assume you are running in WSL, so skiping the VM tools'
			exit 0
fi





# DOCKER

#Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	software-properties-common






# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add the docker stable repository
sudo add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) \
	stable"

# update
apt-get update -y

# install docker
apt-get install -y docker-ce


# configure the proxy for docker
sudo mkdir -p /etc/systemd/system/docker.service.d/


sudo systemctl daemon-reload
sudo systemctl restart docker





# DOCKER COMPOSE

# Docker-compose
COMPOSE_VERSION="v2.23.0"

sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)"  -o /usr/local/bin/docker-compose
sudo mv /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose






# Kubectl
sudo apt-get update -y && sudo apt-get install -y apt-transport-https gnupg2
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt-get install -y kubectl




# Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm ./get_helm.sh







# MINIKUBE

# Minikube Variables
KUBERNETES_VERSION="1.31.2"





# Kubernetes >1.20.2 requirements
sudo apt-get install -y conntrack

## /usr/sbin/iptables needs to be in path for minikube driver=none
export PATH=$PATH:/usr/sbin/

# Install minikube
curl -sLo minikube https://storage.googleapis.com/minikube/releases/v${KUBERNETES_VERSION}/minikube-linux-amd64 2>/dev/null
chmod +x minikube
sudo cp minikube /usr/local/bin && rm minikube

# Start minikube with no vm driver, dynamic audit enabled
minikube start --driver=none \
	  --apiserver-ips 127.0.0.1 \
	    --listen-address 0.0.0.0 \
	      --apiserver-name localhost
  # --feature-gates=DynamicAuditing=true \
    # --extra-config=apiserver.audit-dynamic-configuration=true \
      # --extra-config=apiserver.runtime-config=auditregistration.k8s.io/v1alpha1

# Assign kubeconfig 
sudo cp -R $RHOME/.kube $RHOME/.minikube $VHOME/
sudo chown -R $MYUSER $RHOME/.kube $RHOME/.minikube $RHOME $VHOME/.kube



######################################### 2
