from typing import Union

from rest_framework import serializers
from rest_framework.relations import PrimaryKeyRelatedField
from .models import Review
from django.apps import apps

users_app = apps.get_app_config("users")
client = users_app.get_model("Client")
mechanic = users_app.get_model("Mechanic")
print(f"{client = } -- {mechanic = }")


class ReviewSerializer(serializers.ModelSerializer):
    client = PrimaryKeyRelatedField(queryset=client.objects.all())
    mechanic = PrimaryKeyRelatedField(queryset=mechanic.objects.all())
    error_response = None

    class Meta:
        model = Review
        fields = "__all__"

    def save(self, validated_data) -> Union[Review, dict]:
        """Handles possible extra operations in reviews saving process."""
        try:
            validated_data['client'] = client.objects.get(id=validated_data.get('client', None))
            validated_data['mechanic'] = mechanic.objects.get(id=validated_data.get('mechanic', None))
            review_instance = self.Meta.model(**validated_data)
            review_instance.save()
            return review_instance
        except Exception as e:
            print(f"{e = }")
            self.error_response = {"failure_message": "couldn't receive the review"}
