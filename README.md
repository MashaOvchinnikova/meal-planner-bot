# 🍳 Smart Meal Planner — Умный кулинарный помощник

[![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)](https://python.org)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.115+-green.svg)](https://fastapi.tiangolo.com)
[![Aiogram](https://img.shields.io/badge/Aiogram-3.x-blue.svg)](https://docs.aiogram.dev)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16+-blue.svg)](https://postgresql.org)
[![Redis](https://img.shields.io/badge/Redis-7.x-red.svg)](https://redis.io)
[![RabbitMQ](https://img.shields.io/badge/RabbitMQ-4.x-orange.svg)](https://rabbitmq.com)
[![Docker](https://img.shields.io/badge/Docker-✓-blue.svg)](https://docker.com)

Telegram-бот и веб-сервис для планирования питания, управления рецептами и автоматического формирования списка покупок. Проект построен на асинхронной архитектуре с использованием брокера сообщений для обработки событий.

---

## ✨ Возможности

### 🤖 Telegram-бот
- 🔍 **Поиск рецептов** — по названию и ингредиентам с пагинацией
- 📅 **Планирование питания** — составляй меню на неделю (завтрак/обед/ужин)
- 🛒 **Умный список покупок** — автоматически собирает ингредиенты из запланированных блюд
- ⏰ **Напоминания** — ежедневные уведомления о планах на завтра (в 20:00)
- ➕ **Добавление рецептов** — через интерактивные формы с пошаговым вводом
- 📊 **Личная статистика** — любимые блюда, частота приготовления

### 🌐 Web API (FastAPI)
- 👥 **Управление пользователями** — регистрация, настройки, профили
- 📝 **CRUD для рецептов** — создание, редактирование, удаление
- 📈 **Аналитика** — популярные рецепты, статистика использования
- 📤 **Экспорт** — список покупок в PDF для печати
- 🔌 **Интеграции** — погода, цены из магазинов

---
Проект построен на **микросервисной архитектуре** с брокером сообщений:
[Telegram Bot] → (событие) → [RabbitMQ] → [Сервис уведомлений]
                           ↘ [RabbitMQ] → [Сервис генерации списков]
[FastAPI]      → (событие) → [RabbitMQ] → [Сервис аналитики]
[PostgreSQL] ← [Redis (кэш/FSM)] ← [Все сервисы]

### Ключевые компоненты:
- **aiogram 3.x** — асинхронный Telegram бот с машиной состояний
- **FastAPI** — REST API с автоматической Swagger-документацией
- **PostgreSQL** — основная база данных (SQLAlchemy 2.0 + Alembic)
- **Redis** — кэширование и хранилище состояний FSM
- **RabbitMQ** — брокер событий для асинхронной обработки
- **Docker** — контейнеризация всех сервисов
  
### Структура проекта
meal-planner/
├── app/
│   ├── bot/                      # Telegram бот
│   │   ├── handlers/              # Обработчики команд
│   │   ├── keyboards/             # Клавиатуры (inline/reply)
│   │   ├── middlewares/           # Мидлвари (аутентификация, логи)
│   │   └── states/                 # Машина состояний (FSM)
│   ├── api/                       # FastAPI
│   │   ├── v1/                     # Версионирование API
│   │   │   ├── recipes.py          # Эндпоинты рецептов
│   │   │   ├── meal_plans.py       # Эндпоинты планов
│   │   │   └── shopping_list.py    # Эндпоинты списков
│   │   └── dependencies.py         # Зависимости (БД, текущий пользователь)
│   ├── core/                       # Ядро
│   │   ├── config.py                # Pydantic конфиг (настройки из .env)
│   │   ├── database.py              # Подключение к БД (asyncpg)
│   │   ├── models.py                 # SQLAlchemy модели
│   │   └── redis.py                  # Redis клиент (aioredis)
│   ├── services/                    # Бизнес-логика
│   │   ├── recipe_service.py         # Поиск и фильтрация рецептов
│   │   ├── shopping_list_generator.py # Генерация списков (агрегация)
│   │   └── notification_service.py    # Уведомления и напоминания
│   ├── scheduler/                    # Фоновые задачи
│   │   ├── tasks.py                   # Celery задачи
│   │   └── reminders.py                # Шедулеры (APScheduler)
│   ├── utils/                         # Вспомогательное
│   │   ├── external_api.py             # Интеграции (погода, магазины)
│   │   └── validators.py               # Валидаторы данных
│   ├── migrations/                     # Alembic миграции
│   └── tests/                          # Тесты (pytest)
├── docker-compose.yml
├── Dockerfile
├── .env.example
├── .gitignore
└── requirements.txt

