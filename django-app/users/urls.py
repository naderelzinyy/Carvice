

from django.contrib import admin
from django.urls import path, include
from .views import SignupView, MechanicSignInView, ClientSignInView, UserView, SignOutView, UpdateUserInfo, CarInfo

urlpatterns = [
    path('signup', SignupView.as_view()),
    path('mechanic/signin', MechanicSignInView.as_view()),
    path('client/signin', ClientSignInView.as_view()),
    path('signout', SignOutView.as_view()),
    path('user', UserView.as_view()),
    path('updateInfo', UpdateUserInfo.as_view()),
    path('carInfo', CarInfo.as_view()),

]
