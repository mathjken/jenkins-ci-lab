FROM python:3.13-slim

WORKDIR /app

COPY app.py .
COPY requirements.txt .

CMD ["python", "app.py"]
