#!/bin/bash

target_scheme="${1:-dark}"

# tilix theme
TILIX_TARGET="/com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d"

apply() {
	# gtk theme
	gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"

	# vscode theme
	sed -i "s/\"workbench.colorTheme\": \"\(.*\)\"/\"workbench.colorTheme\": \"${VSCODE_THEME}\"/" ~/.config/Code/User/settings.json
	sed -i "s/\"workbench.colorTheme\": \"\(.*\)\"/\"workbench.colorTheme\": \"${VSCODE_THEME}\"/" ~/.config/Code\ -\ OSS/User/settings.json
	sed -i "s/\"workbench.colorTheme\": \"\(.*\)\"/\"workbench.colorTheme\": \"${VSCODE_THEME}\"/" ~/.config/Code\ -\ Insiders/User/settings.json

	# alacritty config
	cp "$ALACRITTY_CONFIG" ~/.config/alacritty/alacritty.yml
}

apply_dark() {
	VSCODE_THEME="Default Dark+"
	GTK_THEME="adw-gtk3-dark"
	ALACRITTY_CONFIG=~/.config/alacritty/alacritty.dark.yml
	apply

	# chrome
	# sed -i "s/#--force-dark-mode/--force-dark-mode/" ~/.config/chrome-flags.conf
	# sed -i "s/#--enable-features=WebUIDarkMode/--enable-features=WebUIDarkMode/" ~/.config/chrome-flags.conf

	# tilix theme
	# dconf write $TILIX_TARGET/use-theme-colors 'true'
	# dconf write $TILIX_TARGET/palette "['#2E2E34343636', '#CCCC00000000', '#4E4E9A9A0606', '#C4C4A0A00000', '#34346565A4A4', '#757550507B7B', '#060698209A9A', '#D3D3D7D7CFCF', '#555557575353', '#EFEF29292929', '#8A8AE2E23434', '#FCFCE9E94F4F', '#72729F9FCFCF', '#ADAD7F7FA8A8', '#3434E2E2E2E2', '#EEEEEEEEECEC']"

	gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
}

apply_light() {
	VSCODE_THEME="Default Light+"
	GTK_THEME="adw-gtk3"
	ALACRITTY_CONFIG=~/.config/alacritty/alacritty.light.yml
	apply

	# chrome
	# sed -i "s/--force-dark-mode/#--force-dark-mode/" ~/.config/chrome-flags.conf
	# sed -i "s/--enable-features=WebUIDarkMode/#--enable-features=WebUIDarkMode/" ~/.config/chrome-flags.conf

	# tilix theme
	# dconf write "$TILIX_TARGET/use-theme-colors" 'false'
	# dconf write "$TILIX_TARGET/background-color" "'#F3F3F3F3F3F3'"
	# dconf write "$TILIX_TARGET/foreground-color" "'#000000000000'"
	# dconf write "$TILIX_TARGET/palette" "['#2E2E34343636', '#CCCC00000000', '#4E4E9A9A0606', '#C4C4A0A00000', '#34346565A4A4', '#757550507B7B', '#060698209A9A', '#D3D3D7D7CFCF', '#555557575353', '#EFEF29292929', '#8A8AE2E23434', '#FCFCE9E94F4F', '#72729F9FCFCF', '#ADAD7F7FA8A8', '#3434E2E2E2E2', '#EEEEEEEEECEC']"

	gsettings set org.gnome.desktop.interface color-scheme "default"
}

is_dark() {
  if gsettings get org.gnome.desktop.interface gtk-theme | grep -q dark; then
	  return 0
  else
	  return 1
  fi
}

case "$target_scheme" in
	info)
		is_dark && echo 'dark' || echo 'light'
		;;
	toggle)
		if is_dark; then
			apply_light
		else
			apply_dark
		fi
		;;

	dark)
		echo "Dark.... apply"
		apply_dark
		;;

	light)
		echo "Light... apply"
		apply_light
		;;

	*)
		echo "Unknown scheme ${target_scheme} please specify..."
		;;
esac
