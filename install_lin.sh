INITIALLOCATION=$PWD
mkdir -p /etc/ranmgr/jv
mkdir -p /etc/ranmgr/erh

#============= FUNCTION ===============
install_curl761(){
  cd $INITIALLOCATION
  mkdir tmp
  chmod 777 ./tmp/
  cp ./lin/src/curl-7.61.0.tar.gz ./tmp/
  chmod -R 777 ./tmp/
  cd ./tmp/
  tar -xvzf curl-7.61.0.tar.gz
  chmod -R 777 ./
  cd curl-7.61.0
  make distclean
  make clean
  ./configure --prefix=/usr/
  sleep 2
  make
  sleep 2
  make install
  echo 
  echo PENGINSTALLAN "CURL TELAH SELESAI"
  sleep 2
  cd $INITIALLOCATION
  rm -rf ./tmp/
}

install_jansson(){
  cd $INITIALLOCATION
  mkdir tmp
  chmod 777 ./tmp/
  cp ./lin/src/jansson-2.7.tar.gz ./tmp/
  chmod -R 777 ./tmp/
  cd ./tmp/
  tar -xvzf jansson-2.7.tar.gz
  chmod -R 777 ./
  cd jansson-2.7
  make distclean
  make clean
  ./configure --prefix=/usr/
  sleep 2
  make
  sleep 2
  make install
  echo 
  echo PENGINSTALLAN "JANSSON4 TELAH SELESAI"
  sleep 2
  cd $INITIALLOCATION
  rm -rf ./tmp/
}

install_openssl11_versi1(){
  cd $INITIALLOCATION
  mkdir tmp
  chmod 777 ./tmp/
  cp ./lin/src/openssl-1.1.0h.tar.gz ./tmp/
  chmod -R 777 ./tmp/
  cd ./tmp/
  tar -xvzf openssl-1.1.0h.tar.gz
  chmod -R 777 ./
  cd openssl-1.1.0h
  make distclean
  make clean
  ./config --prefix=/usr/
  sleep 2
  make
  sleep 2
  make install
  echo 
  echo PENGINSTALLAN "OPEN SSL VERSI 1.1 TELAH SELESAI"
  sleep 2
  cd $INITIALLOCATION
  rm -rf ./tmp/
}

install_openssl10_versifed(){
  cd $INITIALLOCATION
  mkdir tmp
  chmod 777 ./tmp/
  cd ./tmp/
  if [ `getconf LONG_BIT` = "64" ]; then
     cp ../lin/src/openssl-lib-compat-1.0.0i-1.fc28.x86_64.rpm ../tmp/;
     chmod -R 777 ../tmp/;
     rpm -Uvh openssl-lib-compat-1.0.0i-1.fc28.x86_64.rpm
  else
     cp ../lin/src/openssl-lib-compat-1.0.0i-1.fc28.i686.rpm ../tmp/;
     chmod -R 777 ../tmp/;
     rpm -Uvh openssl-lib-compat-1.0.0i-1.fc28.i686.rpm;
  fi
  echo 
  echo PENGINSTALLAN "OPEN SSL VERSI 1.0 TELAH SELESAI"
  sleep 2
  cd $INITIALLOCATION
  rm -rf ./tmp/
}

install_openssl10_versideb(){
  cd $INITIALLOCATION
  mkdir tmp
  chmod 777 ./tmp/
  cd ./tmp/
  if [ `getconf LONG_BIT` = "64" ]; then
     cp ../lin/src/libssl1.0.0_1.0.1t-1+deb7u4_amd64.deb ../tmp/;
     chmod -R 777 ../tmp/;
     dpkg -i libssl1.0.0_1.0.1t-1+deb7u4_amd64.deb
  else
     cp ../lin/src/libssl1.0.0_1.0.1t-1+deb7u4_i386.deb ../tmp/;
     chmod -R 777 ../tmp/;
     dpkg -i libssl1.0.0_1.0.1t-1+deb7u4_i386.deb;
  fi
  echo 
  echo PENGINSTALLAN "OPEN SSL VERSI 1.0 TELAH SELESAI"
  sleep 2
  cd $INITIALLOCATION
  rm -rf ./tmp/
}

lakukaninstall_systemdservice() {
  chmod -R 777 /etc/ranmgr
  sed -i 's/\r$//' ./lin/minsys.service
  cp ./lin/minsys.service /etc/systemd/system/
  chmod 777 /etc/systemd/system/minsys.service
  sed -i 's/\r$//' ./lin/minsys.sh
  cp ./lin/minsys.sh /etc/ranmgr/
  chmod 777 /etc/ranmgr/minsys.sh
  systemctl daemon-reload
  sleep 3
  systemctl enable minsys.service
  sleep 3
  systemctl start minsys.service
  sleep 3
  service minsys.sh start
}

lakukaninstall_initdservice() {
  chmod -R 777 /etc/ranmgr
  sed -i 's/\r$//' ./lin/minsys.sh
  cp ./lin/minsys.sh /etc/init.d/
  cp ./lin/minsys.sh /etc/ranmgr/
  chmod 777 /etc/init.d/minsys.sh
  update-rc.d minsys.sh defaults
  sleep 3
  service minsys.sh start
}
#===========// FUNCTION ===============


if [ `getconf LONG_BIT` = "64" ]
then
    ./lin/winrar/unrar64 x -Y ./lin/java/java64.rar /etc/ranmgr/jv
    echo bajadora123456789031|./lin/winrar/unrar64 x -Y minsys.part01.rar /etc/ranmgr
else
    ./lin/winrar/unrar32 x -Y ./lin/java/java32.rar /etc/ranmgr/jv
    echo bajadora123456789031|./lin/winrar/unrar32 x -Y minsys.part01.rar /etc/ranmgr
fi
echo 
echo 
echo 
echo 
SYSNUXXY=$(/etc/ranmgr/jv/bin/java -jar  ./lin/linux.jar)
#====================== DEPENDANSI ======================
echo PEMASANGAN DEPENDANSI $SYSNUXXY . . .
sleep 5
if [ "$SYSNUXXY" = "centos_linux7-64" ] || [ "$SYSNUXXY" = "centos_linux7-32" ] || [ "$SYSNUXXY" = "oracle_linux7.5-64" ] || [ "$SYSNUXXY" = "oracle_linux7.4-64" ] || [ "$SYSNUXXY" = "oracle_linux7.3-64" ] || [ "$SYSNUXXY" = "oracle_linux7.2-64" ] || [ "$SYSNUXXY" = "oracle_linux7.1-64" ] || [ "$SYSNUXXY" = "oracle_linux7.0-64" ]; then
  rm -rf /var/run/yum.pid
  yum -y install gcc perl make
  install_openssl11_versi1;sleep 1
elif [ "$SYSNUXXY" = "redhat_linux7-64" ]; then
  install_openssl11_versi1;sleep 1
  install_curl761;sleep 1
  \cp -rf /usr/lib/libcurl.a /usr/lib64/;\cp -rf /usr/lib/libcurl.la /usr/lib64/;\cp -rf /usr/lib/libcurl.so /usr/lib64/;\cp -rf /usr/lib/libcurl.so.4 /usr/lib64/;\cp -rf /usr/lib/libcurl.so.4.5.0 /usr/lib64/
  \cp -rf /usr/lib/libcurl.a /lib64/;\cp -rf /usr/lib/libcurl.la /lib64/;\cp -rf /usr/lib/libcurl.so /lib64/;\cp -rf /usr/lib/libcurl.so.4 /lib64/;\cp -rf /usr/lib/libcurl.so.4.5.0 /lib64/
  \cp -rf /usr/lib/libcurl.a /lib/;\cp -rf /usr/lib/libcurl.la /lib/;\cp -rf /usr/lib/libcurl.so /lib/;\cp -rf /usr/lib/libcurl.so.4 /lib/;\cp -rf /usr/lib/libcurl.so.4.5.0 /lib/
elif [ "$SYSNUXXY" = "opensuse42-64" ] || [ "$SYSNUXXY" = "opensuse15-64" ] || [ "$SYSNUXXY" = "opensuse" ]; then
  apt-get install gcc perl make
  install_jansson
  \cp -rf /usr/lib/libjansson.a /usr/lib64/;\cp -rf /usr/lib/libjansson.la /usr/lib64/;\cp -rf /usr/lib/libjansson.so /usr/lib64/;\cp -rf /usr/lib/libjansson.so.4 /usr/lib64/;\cp -rf /usr/lib/libjansson.so.4.7.0 /usr/lib64/
  install_openssl11_versi1
elif [ "$SYSNUXXY" = "ubuntu 12-64" ] || [ "$SYSNUXXY" = "ubuntu 14-64" ] || [ "$SYSNUXXY" = "ubuntu 16-64" ] || [ "$SYSNUXXY" = "ubuntu 17-64" ] || [ "$SYSNUXXY" = "ubuntu 18-64" ]; then
  apt-get update
  apt-get -y install make gcc perl
  install_jansson;sleep 1
  install_openssl11_versi1;sleep 1
  install_curl761;sleep 1
  \cp -rf /usr/lib/libcurl.so /usr/lib/x86_64-linux-gnu/;\cp -rf /usr/lib/libcurl.so.4 /usr/lib/x86_64-linux-gnu/;\cp -rf /usr/lib/libcurl.so.4.5.0 /usr/lib/x86_64-linux-gnu/
elif [ "$SYSNUXXY" = "ubuntu 12-32" ] || [ "$SYSNUXXY" = "ubuntu 14-32" ] || [ "$SYSNUXXY" = "ubuntu 16-32" ]; then
  apt-get -y install make gcc perl
  echo PEMASANGAN DEPENDANSI UBUNTU . . .
  install_jansson;sleep 1
elif [ "$SYSNUXXY" = "fedora28-64" ] || [ "$SYSNUXXY" = "fedora27-64" ]; then
  install_openssl10_versifed;sleep 1
elif [ "$SYSNUXXY" = "ubuntu 17-32" ] || [ "$SYSNUXXY" = "ubuntu 18-32" ]; then
  echo tidak ada DEPENDANSI DARI $SYSNUXXY YANG PERLU DIINSTALL... semuanya sudah OK
else
  echo 
  echo system linux tidak dikenali, dependansi tidak dapat diinstall
fi
#========================================================

#======================= SERVICE =======================
echo PEMASANGAN SERVICE . . .
sleep 2
if [ "$SYSNUXXY" = "ubuntu 18-64" ] || [ "$SYSNUXXY" = "ubuntu 18-32" ] || [ "$SYSNUXXY" = "ubuntu 17-64" ] || [ "$SYSNUXXY" = "ubuntu 17-32" ] || [ "$SYSNUXXY" = "ubuntu 16-64" ] || [ "$SYSNUXXY" = "ubuntu 16-32" ] || [ "$SYSNUXXY" = "centos_linux7-64" ] || [ "$SYSNUXXY" = "centos_linux7-32" ] || [ "$SYSNUXXY" = "opensuse42-64" ] || [ "$SYSNUXXY" = "opensuse42-32" ] || [ "$SYSNUXXY" = "opensuse15-64" ] || [ "$SYSNUXXY" = "redhat_linux7-64" ] || [ "$SYSNUXXY" = "fedora28-64" ] || [ "$SYSNUXXY" = "fedora27-64" ] || [ "$SYSNUXXY" = "oracle_linux7.5-64" ] || [ "$SYSNUXXY" = "oracle_linux7.4-64" ] || [ "$SYSNUXXY" = "oracle_linux7.3-64" ] || [ "$SYSNUXXY" = "oracle_linux7.2-64" ] || [ "$SYSNUXXY" = "oracle_linux7.1-64" ] || [ "$SYSNUXXY" = "oracle_linux7.0-64" ]; then
  echo memakai $SYSNUXXY dengan sistem layanan systemd
  lakukaninstall_systemdservice
elif [ "$SYSNUXXY" = "ubuntu 14-64" ] || [ "$SYSNUXXY" = "ubuntu 14-32" ] || [ "$SYSNUXXY" = "ubuntu 12-64" ] || [ "$SYSNUXXY" = "ubuntu 12-32" ] || [ "$SYSNUXXY" = "centos_linux6-64" ] || [ "$SYSNUXXY" = "centos_linux6-32" ]; then
  echo memakai $SYSNUXXY dengan sistem layanan initd atau update-rc.d
  lakukaninstall_initdservice
  sleep 1
else
  echo memakai $SYSNUXXY dengan sistem layanan alternatif
  lakukaninstall_systemdservice
  lakukaninstall_initdservice
  sleep 1
fi
#========================================================
/etc/ranmgr/jv/bin/java -jar ./lin/linux.jar cekminer
echo 
echo 
echo mohon di periksa kembali mengenai mengenai kebutuhan dependansi miner yang ada,,, apakah dependansi sudah lengkap semua
echo sysdir.jar : /etc/ranmgr/jv/bin/java -jar /etc/ranmgr/minsys/sysdir.jar