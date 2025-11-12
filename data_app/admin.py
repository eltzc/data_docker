from django.contrib import admin

from .models import StudentData # Импортируем вашу модель

# Регистрируем модель StudentData в админке
admin.site.register(StudentData)
