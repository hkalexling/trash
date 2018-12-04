# trash

```bash
wget https://raw.githubusercontent.com/hkalexling/trash/master/trash.sh
chmod +x trash.sh
./trash.sh
```

```
This is a simple wrapper around trash-cli: https://github.com/andreafrancia/trash-cli

Usage:
  trash [ACTION] [OPTIONS]... [FILE]...

Actions available:
  put, list, empty, restore, uninstall, help

Example usage:
  trash put FILE: move file(s) to trashcan
  trash FILE: shortcut for trash put FILE
  trash list: list files in trashcan
  trash empty: empty the trashcan
  trash restore: restore file(s) from the trashcan
  trash uninstall: uninstall this wrapper and use the vanilla trash-cli
  trash help: show this help message again
  trash ACTION --help: show individual help message for the above actions
 ```
