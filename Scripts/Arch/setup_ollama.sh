paru -S ollama
sudo systemctl disable --now ollama
sudo systemctl start ollama

sudo systemctl edit ollama
# [Service]
# Environment="OLLAMA_KEEP_ALIVE=2m"
# Environment="OLLAMA_CONTEXT_LENGTH=32768"

sudo systemctl daemon-reload
sudo systemctl restart ollama

ollama pull qwen2.5-coder:7b
ollama pull qwen2.5-coder:3b

ollama ls

paru -S opencode
