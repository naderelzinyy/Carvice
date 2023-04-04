

from django.contrib import admin
from django.urls import path, include
from .views import SignupView

urlpatterns = [
    path('signup', SignupView.as_view()),

]
