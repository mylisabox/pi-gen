#!/bin/bash -e

on_chroot <<EOF

  wget https://nodejs.org/dist/latest-v10.x/node-v10.22.0-linux-armv7l.tar.xz
  mkdir -p /usr/local/lib/nodejs;
  tar -xJvf node-v10.22.0-linux-armv7l.tar.xz -C /usr/local/lib/nodejs;
  rm node-v10.22.0-linux-armv7l.tar.xz;
  ln -fs /usr/local/lib/nodejs/node-v10.22.0-linux-armv7l/bin/node /usr/bin/node;
  ln -fs /usr/local/lib/nodejs/node-v10.22.0-linux-armv7l/bin/npm /usr/bin/npm;
  ln -fs /usr/local/lib/nodejs/node-v10.22.0-linux-armv7l/bin/npx /usr/bin/npx;

EOF

on_chroot <<EOF
npm --version
node --version
EOF

on_chroot <<EOF
#yarn global add forever
npm i forever --only=prod -g --unsafe-perm

if [ ! -d "/var/www" ]; then
  mkdir /var/www
fi

cd /var/www || exit

echo "Cloning or update L.I.S.A."
if [ ! -d "/var/www/lisa-box" ]; then
  git clone https://github.com/mylisabox/lisa-box
  cd lisa-box || exit
  echo "Install L.I.S.A. deps"
else
  cd lisa-box || exit
  git pull
fi
npm i --only=prod --unsafe-perm
#yarn
echo "L.I.S.A. setup in /var/www/lisa-box"

EOF

#plugins=('lisa-plugin-hue' 'lisa-plugin-kodi' 'lisa-plugin-ir' 'lisa-plugin-voice' 'lisa-plugin-cam-mjpeg' 'lisa-plugin-sony-vpl' 'lisa-plugin-bose-soundtouch')
#echo "Install L.I.S.A. plugins ${plugins[@]}"
#for plugin in ${plugins[@]};do
#on_chroot <<EOF
#  cd /var/www/lisa-box/plugins || exit
#  if [ ! -d "${plugin}" ]; then
#    echo "Cloning ${plugin}"
#    git clone "https://github.com/mylisabox/${plugin}"
#    cd "${plugin}" || exit
#    echo "Installing deps ${plugin}"
#  else
#    echo "${plugin} already exist, updating"
#    cd "${plugin}" || exit
#    git pull
#  fi
#  npm i --only=prod --unsafe-perm
#  #yarn
#EOF
#done

on_chroot <<EOF
if [ ! -d "/etc/init.d/lisa" ]; then
  echo "Setup L.I.S.A. at startup"
  cd /etc/init.d/ || exit
  wget https://raw.githubusercontent.com/mylisabox/lisa-box/master/scripts/lisa
  chmod 755 /etc/init.d/lisa
  update-rc.d lisa defaults
fi
echo "L.I.S.A. setup is finished"
EOF
