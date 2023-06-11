
from django.urls import path
from .views import GetAvailableMechanics, AddMechanicLocation

urlpatterns = [
    path('getNearMechanics', GetAvailableMechanics.as_view()),
    path('addMechanicLocation', AddMechanicLocation.as_view()),

]
