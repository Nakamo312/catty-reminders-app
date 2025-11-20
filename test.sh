#!/bin/bash
echo "🧪 Запуск тестов..."

python3 -m pytest tests/test_unit.py -v --tb=short

echo "✅ Тестирование завершено"
exit 0
