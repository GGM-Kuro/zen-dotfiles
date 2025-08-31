function cdd() {
	cd "$(ls -d -- */ | fzf)" || echo "Invalid directory"
}


function recent_dirs() {
	# This script depends on pushd. It works better with autopush enabled in ZSH
	escaped_home=$(echo $HOME | sed 's/\//\\\//g')

	selected=$(dirs -p | sort -u | fzf)

	cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}


# utils
function cleartarget(){
    echo '' >! $DOTFILES_PATH/scripts/target

}


function settarget(){
    ip_address=$1
    machine_name=$2
    echo " $ip_address $machine_name" >! $DOTFILES_PATH/scripts/target

}


function pj() {


    if [[ ! -d "$PROJECTS" ]];
      then mkdir -p $PROJECTS
    fi

    main_folder=$(find "$PROJECTS" -mindepth 1 -maxdepth 1 -type d \
        | xargs -I{} basename {} \
        | fzf --header="📍 Mis Projectos: $PROJECTS") || return 1

    sub_folders=$(find "$PROJECTS/$main_folder" -mindepth 1 -maxdepth 1 -type d \
        | xargs -I{} basename {})

    if [[ -z "$sub_folders" ]]; then
        cd "$PROJECTS/$main_folder" || return 1
        return 0

    fi

    sub_folder=$(echo "$sub_folders" | \
	    fzf --header="📍 Ruta actual: $PROJECTS/$main_folder")


    if [[ -z "$sub_folder" ]]; then
        cd "$PROJECTS/$main_folder" || return 1
    else
        cd "$PROJECTS/$main_folder/$sub_folder" || return 1
    fi
}

