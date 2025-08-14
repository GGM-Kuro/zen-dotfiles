PROMPT_COMMAND="kuro_theme;"

GREEN_COLOR="32"
RED_COLOR="31"

kuro_theme() {
	local EXIT=$?
	current_dir=$($DOTFILES_PATH/scripts/short_pwd)
	MIDDLE_CHARACTER="✓"
	STATUS_COLOR=$GREEN_COLOR

	if [ $EXIT != 0 ]; then
		STATUS_COLOR=$RED_COLOR
	fi

	export PS1="\[\e[36m\]• \[\e[34m\]${current_dir}\[\e[m\]\[\e[${STATUS_COLOR}m\] →\[\e[m\] "
}
