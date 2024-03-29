
from django.urls import path
from .views import GetAvailableMechanics, AddMechanicLocation, GetMechanicAddressInfo, UpdateMechanicInfo

urlpatterns = [
    path('getNearMechanics', GetAvailableMechanics.as_view()),
    path('addMechanicLocation', AddMechanicLocation.as_view()),
    path('getMechanicAddressInfo', GetMechanicAddressInfo.as_view()),
    path('updateMechanicInfo', UpdateMechanicInfo.as_view()),

]
