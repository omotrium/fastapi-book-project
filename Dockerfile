# Use an official Python image as base
FROM python:3.10

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Copy your Python app
WORKDIR /app
COPY . /app

# Install dependencies
RUN pip install -r requirements.txt

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80

# Start Nginx and your Python app
CMD service nginx start && uvicorn app:app --host 0.0.0.0 --port 8000
