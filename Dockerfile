from ubuntu-base
run cd /tmp \
	&& curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
	&& chmod u+x nvim.appimage \
	&& ./nvim.appimage --appimage-extract	\
	&& cp -r squashfs-root/usr /
run mkdir /nvim \
	&& cp -r /etc/skel /nvim
run mkdir -p /nvim/skel/.config/nvim
copy init.lua /nvim/skel/.config/nvim
