#!/bin/bash
#
# plist-gist enables backup of package list to a GitHub Gist

GIST_FILENAME="arch_packages_$(hostname)"

gist_backup(){
    # Add Ruby to PATH
    PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

    # Load Config
    [[ -r '/etc/plist-gist' ]] && source $pkgdir/etc/plist-gist

    # Determine if Fresh Install is Needed
    if [ -z "$GIST_ID" ]; then
      echo -e "Error: Gist Backup not Setup.\n"
      echo "Run"
	  echo "sudo sh -c 'source /usr/lib/plist-gist/plist-gist.sh; gist_backup_install'"
	  echo "and follow instructions."
    else
      gist_backup_update;
    fi
}

gist_backup_install(){
  echo -e "\nGist Backup is a alpm hook which saves an updated"
  echo -e "version of your package list privately to your GitHub Account"
  echo -e "with every package installation.\n";

  echo -e "\nStep 1: Login to Gist";
  gist --login;

  echo -e "\nStep 2: Creating Backup";
  GIST_URL=$(pacman -Qq | gist -p -f "$GIST_FILENAME" -d "Arch Package Backup List generated by Plist-Gist")

  echo "GIST_ID=$GIST_URL" | sed 's/https:\/\/gist.github.com\///g' >> $pkgdir/etc/plist-gist;

  echo -e "\nYour package list is safely backed up, and will be updated"
  echo -e "automatically every time you install a package using a package manager,"
  echo -e "You can view your backup at the link below:\n";
  echo "$GIST_URL";
}

gist_backup_update(){
  echo -e "\nUpdating Package List Backup...";
  if pacman -Qq | gist -f "$GIST_FILENAME" -u "$GIST_ID"; then
    echo -e "Success!\n";
  else
    echo -e "An error has occured.\nTry running yaourt -S plist-gist";
  fi

}

gist_backup
