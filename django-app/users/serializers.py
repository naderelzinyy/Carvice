from rest_framework import serializers
from rest_framework.relations import PrimaryKeyRelatedField

from .models import User, Car


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'username', 'email', 'password', 'phone_number', 'is_mechanic', 'is_client']
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

    class Meta:
        model = Car
        fields = "__all__"

    def save(self, validated_data) -> Car:
        """Handles possible extra operations in car creation."""
        print("create car serializer starts")
        car_instance = None
        try:
            validated_data['owner'] = User.objects.get(id=validated_data.get('owner', None))
            car_instance = self.Meta.model(**validated_data)
            print(f"{validated_data = }")
            car_instance.save()
        except Exception as e:
            print(f"{e = }")
        return car_instance
