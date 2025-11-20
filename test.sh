#!/bin/bash
echo "🧪 Запуск unit-тестов..."

if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
fi

export PYTHONPATH="/home/v1k70r/tmp/catty-reminders-app:$PYTHONPATH"

if python3 -m pytest tests/test_unit.py -v --tb=short; then
    echo "✅ "
    exit 0
else
    echo "❌"
    exit 1
fi
