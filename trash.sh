# /bin/sh

function help() {
	echo "This is a simple wrapper around trash-cli: https://github.com/andreafrancia/trash-cli"
	echo 
	echo "Usage:"
	echo "  trash [ACTION] [OPTIONS]... [FILE]..."
	echo
	echo "Actions available:"
	echo "  put, list, empty, restore, uninstall, help"
	echo 
	echo "Example usage:"
	echo "  trash put FILE: move file(s) to trashcan"
	echo "  trash FILE: shortcut for trash put FILE"
	echo "  trash list: list files in trashcan"
	echo "  trash empty: empty the trashcan"
	echo "  trash restore: restore file(s) from the trashcan"
	echo "  trash uninstall: uninstall this wrapper and use the vanilla trash-cli"
	echo "  trash help: show this help message again"
	echo "  trash ACTION --help: show individual help message for the above actions"
}

function install() {
	echo "trash is about to be installed following the two steps below:"
	echo "  1." "$t_path" "will be copied to" "$tcli_path_f"
	echo "  2." "$script_path" "will be copied to" "$t_path"
	echo 
	read -p "Proceed? [Y/n] " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
		cp $t_path $tcli_path_f
		cp $script_path $t_path

		if [ $? -eq 0 ]; then
			echo "All set. You can start using trash now."
		else
			tput setaf 1
			echo "Something went wrong."
			tput sgr0
		fi
	fi
}

function uninstall() {
	echo "trash is about to be uninstalled following the two steps below:"
	echo "  1." "$t_path" "will be moved to trashcan"
	echo "  2." "$tcli_path" "will be moved $t_path"
	echo "You will be using the vanilla trash-cli after this operation."
	echo 
	read -p "Proceed? [Y/n] " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
		trash-put $t_path
		mv $tcli_path $t_path

		if [ $? -eq 0 ]; then
			echo "All set. Farewell :-)"
		else
			tput setaf 1
			echo "Something went wrong."
			tput sgr0
		fi
	fi
}

function trash() {
	if [ $# -gt 0 ]; then
		case $1 in
		"list")
			shift
			trash-list $@;;
		"empty")
			tput setaf 1
			read -p "Are you sure? This can not be undone. [Y/n] " -n 1 -r
			tput sgr0
			echo
			if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
				shift
				trash-empty $@
			fi;;
		"restore")
			shift
			trash-restore $@;;
		"put")
			shift
			trash-put $@;;
		"uninstall")
			uninstall;;
		"help")
			help;;
		*)
			trash-put $@
		esac
	else
		trash-put
	fi
}

t_path="$(which trash)"
p_path="$(dirname "$t_path")"
tcli_path_f=$p_path/"trash-cli"
tcli_path="$(which trash-cli)"
script_dir="$( cd "$( dirname "$0" )" >/dev/null && pwd )"
script_path="$script_dir/$(basename $0)"

if [ -z $t_path ]; then
	echo "trash-cli is not installed. Please get it from https://github.com/andreafrancia/trash-cli first."
	exit 1
fi

if [ -z $tcli_path ]; then
	install
else
	trash $@
fi
