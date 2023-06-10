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


class Client(models.Model):
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    account_id = models.ForeignKey(User, on_delete=models.CASCADE)


class Mechanic(models.Model):
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    commercial_name = models.CharField(max_length=255)
    account_id = models.ForeignKey(User, on_delete=models.CASCADE)


class Car(models.Model):
    owner = models.ForeignKey(User, null=True, on_delete=models.CASCADE)
    plate_number = models.CharField(max_length=255, unique=True, default="undefined")
    brand = models.CharField(max_length=255)
    series = models.CharField(max_length=255)
    model = models.CharField(max_length=255)
    year = models.CharField(max_length=4)
    fuel = models.CharField(max_length=255)
    gear = models.CharField(max_length=255)
    engine_power = models.CharField(max_length=255)
