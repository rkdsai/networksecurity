FROM python:3.10-slim-buster

# Set working directory
WORKDIR /app

# Copy only necessary files first (better caching)
COPY requirements.txt /app/

# Install system dependencies in a single step and clean up
RUN apt-get update && \
    apt-get install -y awscli && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies without caching (smaller image)
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . /app

# Command to run the application
CMD ["python3", "app.py"]
