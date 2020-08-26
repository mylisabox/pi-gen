on_chroot <<EOF
  sed -i 's/AdvertiseName=BT WLAN setup/AdvertiseName=mylisabox/' /etc/nymea/nymea-networkmanager.conf
  sed -i 's/PlatformName=nymea-box/PlatformName=mylisabox/' /etc/nymea/nymea-networkmanager.conf
  sed -i 's/ButtonGpio=14//' /etc/nymea/nymea-networkmanager.conf
EOF
