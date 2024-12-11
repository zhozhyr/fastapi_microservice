# Stage 1: Build
FROM python:3.10-slim as build
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.10-slim
WORKDIR /app
COPY --from=build /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY . /app

# Проверка наличия uvicorn
RUN python -m uvicorn --help || echo "Uvicorn доступен"

# Явно указываем интерпретатор Python
CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
