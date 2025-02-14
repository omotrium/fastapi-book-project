#!/bin/sh
# Start Nginx in the background
nginx -g "daemon off;" &

# Start FastAPI
uvicorn app:app --host 0.0.0.0 --port 8000
