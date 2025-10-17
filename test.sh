#!/bin/bash
echo "🧪 Запуск тестов на обновленном коде..."

if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
fi

export PYTHONPATH="/home/v1k70r/tmp/catty-reminders-app:$PYTHONPATH"

echo "🔧 Установка браузеров Playwright..."
playwright install

echo "🌐 Запуск тестового экземпляра приложения на порту 8282..."
uvicorn app.main:app --host 0.0.0.0 --port 8282 &
APP_PID=$!
sleep 5

echo "🚀 Запуск pytest..."
if python3 -m pytest tests/ -v --tb=short; then
    kill $APP_PID 2>/dev/null
    echo "✅ Все тесты прошли успешно"
    exit 0
else
    kill $APP_PID 2>/dev/null
    echo "❌ Некоторые тесты упали"
    exit 1
fi