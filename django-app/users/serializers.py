from typing import Union

from django.db import IntegrityError
from rest_framework import serializers
from rest_framework.relations import PrimaryKeyRelatedField

from .models import User, Car, Client, Mechanic


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'username', 'email', 'password', 'phone_number', 'is_mechanic',
                  'is_client']
        extra_kwargs = {
            'password': {'write_only': True}
        }

    def create(self, validated_data) -> User:
        """Handles extra operations in user creation (e.g. Hashing passwords)."""
        user_instance = self.Meta.model(**validated_data)
        if password := validated_data.pop('password', None):
            user_instance.set_password(password)
        user_instance.save()
        return user_instance


class CarSerializer(serializers.ModelSerializer):
    owner = PrimaryKeyRelatedField(queryset=User.objects.all())
    error_response = None

    class Meta:
        model = Car
        fields = "__all__"

    def save(self, validated_data) -> Union[dict[str, str], Car, None]:
        """Handles possible extra operations in car creation."""
        try:
            validated_data['owner'] = User.objects.get(id=validated_data.get('owner', None))
            validated_data['plate_number'] = validated_data.get("plate_number", None).upper().replace(" ", "")
            car_instance = self.Meta.model(**validated_data)
            print(f"{validated_data = }")
            car_instance.save()
            return car_instance
        except IntegrityError:
            self.error_response = {"failure_message": "plate number exists"}
        except Exception as e:
            print(f"{e = }")
            self.error_response = {"failure_message": "couldn't add the car"}


class ClientSerializer(serializers.ModelSerializer):
    account_id = PrimaryKeyRelatedField(queryset=User.objects.all())

    class Meta:
        model = Client
        fields = "__all__"

    def create(self, validated_data) -> Client:
        """Handles extra operations in Client creation."""
        validated_data['account_id'] = User.objects.get(id=validated_data.get('account_id', None))
        # removing unneeded pairs.
        # validated_data.pop("user_id")
        client_instance = self.Meta.model(**validated_data)
        client_instance.save()
        return client_instance


class MechanicSerializer(serializers.ModelSerializer):
    account_id = PrimaryKeyRelatedField(queryset=User.objects.all())

    class Meta:
        model = Mechanic
        fields = "__all__"

    def create(self, validated_data) -> Mechanic:
        """Handles extra operations in Mechanic creation."""
        try:
            validated_data['account_id'] = User.objects.get(id=validated_data.get('account_id', None))
            # removing unneeded pairs.
            # validated_data.pop("user_id")
            mechanic_instance = self.Meta.model(**validated_data)
            mechanic_instance.save()
            return mechanic_instance
        except Exception as e:
            print(e)
