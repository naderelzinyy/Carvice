

from django.contrib import admin
from django.urls import path, include
from .views import SignupView, SigninView, UserView

urlpatterns = [
    path('signup', SignupView.as_view()),
    path('signin', SigninView.as_view()),
    path('user', UserView.as_view()),

]
