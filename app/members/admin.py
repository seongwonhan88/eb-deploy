
# Register your models here.
from django.contrib import admin
from django.contrib.admin import site

from .models import User

admin.site.register(User)