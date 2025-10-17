#!/bin/bash
echo "🧪 Запуск тестов на обновленном коде..."

if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
fi

export PYTHONPATH="/home/v1k70r/tmp/catty-reminders-app:$PYTHONPATH"

echo "🚀 Запуск pytest..."
if python3 -m pytest tests/ -v --tb=short; then
    echo "✅ Все тесты прошли успешно"
    exit 0
else
    echo "❌ Некоторые тесты упали"
    exit 1
fi
