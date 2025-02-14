# Use official Python image as base for FastAPI
FROM python:3.9-slim as python-base

# Set environment variables for pip
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Set working directory in the container
WORKDIR /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the container
COPY . /app/

# Expose FastAPI app on port 8000
EXPOSE 8000

# Use gunicorn as a process manager for FastAPI
CMD ["gunicorn", "app:app", "--workers", "4", "--bind", "0.0.0.0:8000"]

# Use Nginx image as a base for Nginx setup
FROM nginx:latest

# Remove the default Nginx config and copy our custom config
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
