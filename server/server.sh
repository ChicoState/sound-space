
PORT=8000

# fuser -k 8000/tcp

cd build/web

echo "soundspace server starting on port $PATH"
python3 -m http.server $PORT

echo "server stopping"
