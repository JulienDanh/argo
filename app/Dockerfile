FROM python:3.11-slim

WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install typer for hooks
RUN pip install --no-cache-dir typer==0.9.0

# Copy application code
COPY main.py .

# Copy hooks directory
COPY hooks ./hooks

# Expose port
EXPOSE 8000

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"] 