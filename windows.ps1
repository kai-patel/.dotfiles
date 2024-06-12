# Neovim
New-Item "$env:LOCALAPPDATA\nvim" -ItemType Directory -ErrorAction SilentlyContinue
Copy-Item -Force -Recurse -Verbose ".\nvim\.config\nvim\" -Destination "$env:LOCALAPPDATA\nvim"

# Vim
Copy-Item -Force -Verbose ".\vim\.vimrc" -Destination "$env:USERPROFILE\.vimrc"
