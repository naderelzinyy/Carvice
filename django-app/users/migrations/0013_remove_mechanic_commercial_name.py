# Generated by Django 4.1 on 2023-06-12 23:05

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0012_mechanic_client'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='mechanic',
            name='commercial_name',
        ),
    ]
