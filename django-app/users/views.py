import datetime

import jwt

from rest_framework.response import Response
from rest_framework.exceptions import AuthenticationFailed
from rest_framework.views import APIView
from .serializers import UserSerializer
from django.contrib.auth import get_user_model

# Create your views here.
User = get_user_model()


class SignupView(APIView):

    @staticmethod
    def post(request) -> Response:
        """Handles the registration POST requests."""
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)


class SigninView(APIView):

    @staticmethod
    def post(request) -> Response:
        """Handles the login POST requests."""
        username = request.data.get("username")
        password = request.data.get("password")
        user = User.objects.filter(username=username).first()
        if not user:
            raise AuthenticationFailed("Username doesn't exist.")

        if not user.check_password(password):
            raise AuthenticationFailed("Password isn't correct.")

        payload = {
            "id": user.id,
            "exp": datetime.datetime.now(datetime.timezone.utc)
                   + datetime.timedelta(minutes=60),
            "iat": datetime.datetime.now(datetime.timezone.utc),
        }

        token = jwt.encode(payload=payload, key="secret", algorithm="HS256")
        response = Response()
        response.set_cookie(key="jwt", value=token, httponly=True)
        response.data = {
            "jwt": token,
        }
        return response


class UserView(APIView):

    @staticmethod
    def post(request) -> Response:
        """Handles the UserView POST requests."""
        token = request.COOKIES.get("jwt")
        if not token:
            raise AuthenticationFailed("Unauthorized access.")
        try:
            payload = jwt.decode(jwt=token, key="secret", algorithms=["HS256"])
        except jwt.ExpiredSignatureError as e:
            raise AuthenticationFailed("Unauthorized access.") from e
        user = User.objects.filter(id=payload.get("id")).first()
        return Response(UserSerializer(user).data)


class SignOutView(APIView):
    @staticmethod
    def post(request) -> Response:
        """Handles the Logout POST request."""
        response = Response()
        response.delete_cookie("jwt")
        response.data = {
            "message": "success"
        }

        return response
