# Maintainer: Derek Brown <derekbro@andrew.cmu.edu>
pkgname=plist-gist
pkgver=0.1
pkgrel=1
pkgdesc="Automatically saves package list to Gist"
url="https://github.com/DerekTBrown/plist-gist"
arch=('x86_64' 'i686')
license=('GPL')
depends=('pacman>=5.0' 'gist-git>=4.5.0')
makedepends=('git')
install="plist-gist.install"
source=("plist-gist.hook" "plist-gist.sh")
md5sums=('SKIP' 'SKIP')

package() {
  # Install Save file
  mkdir -p $pkgdir/etc/
  touch $pkgdir/etc/plist-gist

  # Install Script
  mkdir -p $pkgdir/usr/lib/plist-gist
  cp $srcdir/plist-gist.sh $pkgdir/usr/lib/plist-gist/plist-gist.sh
  chmod +x $pkgdir/usr/lib/plist-gist/plist-gist.sh

  # Install Hook
  mkdir -p $pkgdir/usr/share/libalpm/hooks
  cp $srcdir/plist-gist.hook $pkgdir/usr/share/libalpm/hooks/plist-gist.hook
}
