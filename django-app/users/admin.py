from django.contrib import admin
from . import models


# Register your models here.
class UsersAdminArea(admin.AdminSite):
    site_header = 'Carvice Admin Dashboard'


users_site = UsersAdminArea(name='Carvice Admin Dashboard')

users_site.register(models.Mechanic)
users_site.register(models.Client)
users_site.register(models.User)

