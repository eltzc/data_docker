# Dockerfile

# --- Шаг 1: Базовый образ ---
FROM python:3.10-slim

# --- Шаг 2: Установка переменных окружения ---
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SECRET_KEY=${DJANGO_SECRET_KEY}
ENV DEBUG=${DEBUG} 

# --- Шаг 3: Создание и установка рабочей директории ---
WORKDIR /app

# --- Шаг 4: Установка системных зависимостей для сборки ---
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    pkg-config \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# --- Шаг 5: Установка зависимостей Python ---
COPY requirements.txt /app/

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# --- Шаг 6: Копирование кода приложения ---
COPY . /app/

# --- Шаг 7: Сбор статических файлов ---
# Устанавливаем переменные окружения, чтобы collectstatic работал правильно
# Если DEBUG=0, то Django будет искать статику в /app/staticfiles
RUN if [ "$DEBUG" = "0" ]; then python manage.py collectstatic --noinput; fi

# --- Шаг 8: Команда для запуска приложения ---
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "data_project.wsgi:application"] 