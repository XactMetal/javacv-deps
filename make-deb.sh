VERSION=1.5.4
VERSION_X=1.5.4-x1

echo "Make jars..."
./make-jars.sh $@ || {
  echo "Failed"
  exit 1
}

rm -R javacv || true
mkdir -p javacv/usr/share/xact/java/lib/javacv-$VERSION/
mkdir -p javacv/DEBIAN/

echo Package: javacv > javacv/DEBIAN/control
echo Version: $VERSION_X >> javacv/DEBIAN/control
echo Maintainer: Xact Metal >> javacv/DEBIAN/control
echo Architecture: all >> javacv/DEBIAN/control
echo Description: External dependencies for Xact Metal java application >> javacv/DEBIAN/control

mv build/*.jar javacv/usr/share/xact/java/lib/javacv-$VERSION/

# Z flag sets compression to none, gzip, xz
dpkg-deb -Zgzip --build javacv
