from django.db import models
from django.contrib.auth.models import AbstractUser
from phonenumber_field.modelfields import PhoneNumberField

# Create your models here.


class User(AbstractUser):
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    username = models.CharField(max_length=255, unique=True)
    phone_number = PhoneNumberField(blank=True, region='TR')
    email = models.CharField(max_length=255, unique=True)
    password = models.CharField(max_length=255)
    is_mechanic = models.BooleanField("is_mechanic", default=False)
    is_client = models.BooleanField("is_client", default=False)

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = []
