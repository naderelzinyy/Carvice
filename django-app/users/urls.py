

from django.contrib import admin
from django.urls import path, include
from .views import (SignupView,
                    MechanicSignInView,
                    ClientSignInView,
                    UserView,
                    SignOutView,
                    UpdateUserInfo,
                    AddCar,
                    GetCars,
                    UpdateCarInfo,
                    DeleteCar,
                    DepositView,
                    WithdrawView,
                    TransferView, BalanceView, GetMechanicUsername)

urlpatterns = [
    path('signup', SignupView.as_view()),
    path('mechanic/signin', MechanicSignInView.as_view()),
    path('client/signin', ClientSignInView.as_view()),
    path('signout', SignOutView.as_view()),
    path('user', UserView.as_view()),
    path('updateInfo', UpdateUserInfo.as_view()),
    path('addCar', AddCar.as_view()),
    path('getCars', GetCars.as_view()),
    path('updateCar', UpdateCarInfo.as_view()),
    path('deleteCar', DeleteCar.as_view()),
    path('deposit', DepositView.as_view()),
    path('withdraw', WithdrawView.as_view()),
    path('transfer', TransferView.as_view()),
    path('balance/<int:user_id>', BalanceView.as_view()),
    path('getMechanicUsername', GetMechanicUsername.as_view()),
]
