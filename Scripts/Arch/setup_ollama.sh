paru -S ollama
sudo systemctl disable --now ollama
sudo systemctl start ollama

sudo systemctl edit ollama
# [Service]
# Environment="OLLAMA_KEEP_ALIVE=2m"
# Environment="OLLAMA_CONTEXT_LENGTH=32768"

ollama pull qwen2.5-coder:7b # pc
#ollama pull qwen2.5-code:3b # laptop
ollama ls

sudo systemctl daemon-reload
sudo systemctl restart ollama

paru -S opencode
