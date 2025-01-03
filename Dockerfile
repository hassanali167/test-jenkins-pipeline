# Use the official Python image as a base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Python program and requirements to the container
COPY . /app

CMD ["python", "hello.py"]
