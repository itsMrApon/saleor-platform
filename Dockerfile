# Use an official Python image as a base
FROM python:3.10

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy Saleor source code
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Collect static files
RUN python manage.py collectstatic --noinput

# Apply database migrations
RUN python manage.py migrate

# Expose the port Saleor runs on
EXPOSE 8000

# Start Saleor
CMD ["gunicorn", "-b", "0.0.0.0:8000", "saleor.wsgi:application"]
