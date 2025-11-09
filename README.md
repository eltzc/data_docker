# Название вашего проекта

## Описание проекта

Краткое описание вашего Django-проекта.

## Установка и запуск

### Требования

*   Docker
*   Docker Compose

### Быстрый старт (для разработки)

1.  **Клонируйте репозиторий:**
    ```bash
    git clone <URL_ВАШЕГО_РЕПОЗИТОРИЯ>
    cd <НАЗВАНИЕ_ПАПКИ_ПРОЕКТА>
    ```

2.  **Создайте файл `.env`:**
    Скопируйте файл `.env.example` (если есть) или создайте `.env` вручную.
    ```bash
    cp .env.example .env
    ```
    Отредактируйте `.env`, указав ваши настройки для базы данных, секретный ключ Django и `DEBUG=1`.

3.  **Соберите и запустите Docker-контейнеры:**
    ```bash
    docker compose up -d --build
    ```
    *   `-d` запускает контейнеры в фоновом режиме.

4.  **Выполните миграции базы данных:**
    ```bash
    docker compose exec web python manage.py migrate
    ```

5.  **Откройте приложение в браузере:**
    Ваше приложение будет доступно по адресу `http://localhost:8000`.

### Запуск для Production

1.  **Убедитесь, что в `.env` файле:**
    *   `DEBUG=0`
    *   Указан надежный `DJANGO_SECRET_KEY`.
    *   Настройки `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`, `DB_PORT` корректны для вашей production-среды.

2.  **Соберите и запустите Docker-контейнеры:**
    ```bash
    docker compose up -d --build
    ```
    *   Команда `collectstatic` будет выполнена автоматически в `Dockerfile`.

3.  **Выполните миграции базы данных:**
    ```bash
    docker compose exec web python manage.py migrate
    ```

### Остановить контейнеры

```bash
docker compose down