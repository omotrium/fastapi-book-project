#!/bin/sh
# Start Nginx in the background
nginx -g "daemon off;" &

# Start FastAPI
uvicorn main:app --host 0.0.0.0 --port 8000
