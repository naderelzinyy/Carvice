# Generated by Django 4.1 on 2023-04-30 17:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0003_user_is_mechanic_user_phone_number'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='is_client',
            field=models.BooleanField(default=False, verbose_name='is_client'),
        ),
        migrations.AlterField(
            model_name='user',
            name='is_mechanic',
            field=models.BooleanField(default=False, verbose_name='is_mechanic'),
        ),
    ]