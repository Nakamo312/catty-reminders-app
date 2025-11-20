#!/bin/bash
echo "🧪 Запуск тестов на обновленном коде..."

if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
fi

export PYTHONPATH="/home/v1k70r/tmp/catty-reminders-app:$PYTHONPATH"

echo "🔧 Установка браузеров Playwright..."
playwright install


echo "🌐 Запуск тестового экземпляра приложения на порту 8282..."
echo "   Проверяем порт 8282..."
netstat -tulpn | grep 8282 || echo "   Порт 8282 свободен"

uvicorn app.main:app --host 0.0.0.0 --port 8282 &
APP_PID=$!
echo "   PID тестового приложения: $APP_PID"

sleep 5

echo "   Проверяем запустилось ли приложение..."
ps aux | grep $APP_PID || echo "   Процесс не найден"
netstat -tulpn | grep 8282 || echo "   Приложение не слушает порт 8282"

echo "   Проверяем доступность приложения..."
curl -f http://localhost:8282/ || echo "   Приложение не отвечает"

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
