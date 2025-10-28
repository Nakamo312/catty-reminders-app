FROM python:3.11-slim

WORKDIR /app

# Копируем зависимости
COPY requirements.txt .

# Устанавливаем ВСЕ зависимости (пока без фильтрации)
RUN pip install --no-cache-dir -r requirements.txt

# Копируем код приложения
COPY . .

EXPOSE 8181

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8181"]