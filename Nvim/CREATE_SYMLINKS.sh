#!/binbash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

ln -sf "$SCRIPT_DIR" ~/.config/nvim

