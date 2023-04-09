from rest_framework import serializers
from .models import User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'username', 'email', 'password']
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
