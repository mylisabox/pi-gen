#wget -qO - https://deb.nodesource.com/setup_10.x | bash - #no need as installed manually on next script
#wget -qO - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
wget -qO - https://apt.matrix.one/doc/apt-key.gpg | apt-key add -
wget -q https://ftp-master.debian.org/keys/release-10.asc -O- | apt-key add -
#echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
echo "deb http://deb.debian.org/debian $(lsb_release -sc) non-free" | tee /etc/apt/sources.list.d/nonfree.list
echo "deb https://apt.matrix.one/raspbian $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/matrixlabs.list

apt-get update
