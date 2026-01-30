# Use a small, secure Python base image
FROM python:3.11-slim

# Prevent Python from writing .pyc files and buffer logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory inside container
WORKDIR /app

# Install dependencies first (better caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application code
COPY hello.py .
COPY test_app.py .

# Expose the port your app runs on
EXPOSE 5000

# Run with gunicorn (production WSGI server)
CMD ["gunicorn", "-b", "0.0.0.0:5000", "hello:app"]
