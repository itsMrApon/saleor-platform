# Use Saleor's official Docker image
FROM saleor/saleor:latest

# Set working directory
WORKDIR /app

# Copy Saleor source code
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Start Saleor
CMD ["gunicorn", "-b", "0.0.0.0:8000", "saleor.wsgi:application"]
