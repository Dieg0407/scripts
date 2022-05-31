# sets up the path
cd ~
path='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@:\[\033[00m\[[\[\033[01;34m\]\W\[\033[00m\]]\$ '
if grep -q '$path' ".bashrc"; then
  echo "$path" >> ~/.bashrc
fi

