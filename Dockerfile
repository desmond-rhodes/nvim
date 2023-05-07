from ubuntu-base
run apt-get -y install build-essential
run apt-get -y install unzip
run cd /tmp \
	&& curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
	&& chmod u+x nvim.appimage \
	&& ./nvim.appimage --appimage-extract	\
	&& cp -r squashfs-root/usr /
run mkdir /nvim \
	&& cp -r /etc/skel /nvim
run mkdir -p /nvim/skel/.config/nvim
copy init.lua /nvim/skel/.config/nvim

arg username
arg user_uid
arg user_gid
run groupadd --gid $user_gid $username
run useradd --uid $user_uid --gid $user_gid --home-dir /nvim/$user_uid-$user_gid -k /nvim/skel -m $username
user $user_uid:$user_gid
