from rest_framework.response import Response
from rest_framework.exceptions import AuthenticationFailed
from rest_framework.views import APIView
from .serializers import UserSerializer
from django.contrib.auth import get_user_model

# Create your views here.


class SignupView(APIView):

    @staticmethod
    def post(request) -> Response:
        """Handles sending POST requests."""
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)


class SigninView(APIView):
    User = get_user_model()

    def post(self, request) -> Response:
        """Handles the login POST requests."""
        username = request.data.get("username")
        password = request.data.get("password")
        user = self.User.objects.filter(username=username).first()
        if not user:
            raise AuthenticationFailed("Username doesn't exist.")

        if not user.check_password(password):
            raise AuthenticationFailed("Password isn't correct.")

        return Response({
            "message": "success"
        })
