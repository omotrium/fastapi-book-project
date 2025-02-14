# Use an official Python runtime as a parent image
FROM python:3.9-slim as base

# Install dependencies
WORKDIR /app
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the container
COPY . /app/

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Copy the Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports
EXPOSE 8000 80


# Start Nginx and Gunicorn (FastAPI) in the same container
CMD service nginx start && uvicorn -w 4 -b 0.0.0.0:8000 main:app
