# Use an official Python runtime as a parent image
FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Install Poetry (Saleor uses Poetry for dependencies)
RUN curl -sSL https://install.python-poetry.org | python3 -

# Copy only necessary files to install dependencies
COPY pyproject.toml poetry.lock /app/

# Install dependencies
RUN poetry install --no-root --no-dev

# Copy the rest of the application files
COPY . /app

# Expose the port that the app runs on
EXPOSE 8000

# Command to start the application
CMD ["poetry", "run", "python", "manage.py", "runserver", "0.0.0.0:8000"]
