# Define Python version and port as arguments
ARG PYTHON_VERSION=3.12
ARG PORT=5000

# Stage 1: Build stage
FROM python:${PYTHON_VERSION}-alpine AS builder

# Install necessary system dependencies
RUN apk add --no-cache gcc musl-dev libffi-dev

# Set the working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Production stage
FROM python:${PYTHON_VERSION}-alpine

# Redefine the ARGs for this stage
ARG PYTHON_VERSION
ARG PORT

# Create a python user and set the working directory
RUN adduser -D python && mkdir /app && chown python:python /app

# Switch to the python user
USER python

# Set the working directory
WORKDIR /app

# Copy the Flask app source code
COPY --chown=python:python . .

# Copy installed Python dependencies from the builder stage
COPY --from=builder --chown=python:python /usr/local/lib/python${PYTHON_VERSION}/site-packages /usr/local/lib/python${PYTHON_VERSION}/site-packages

# Expose the correct port
EXPOSE $PORT

# Set environment variables
ENV FLASK_PORT=$PORT

# Set the entrypoint
ENTRYPOINT ["python"]

# Set the command to start the Flask server
CMD ["app.py"]