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


class RoleFactory:
    def __init__(self):
        self.role_queries = {
            "client": self.get_client,
            "mechanic": self.get_mechanic,
        }

    @staticmethod
    def get_mechanic(username) -> User:
        return User.objects.filter(username=username, is_mechanic=True).first()

    @staticmethod
    def get_client(username) -> User:
        return User.objects.filter(username=username, is_client=True).first()

    def get_user_instance(self, username, role) -> User:
        """Returns user instance from database given username and role."""
        return self.role_queries.get(role)(username)


class SignInHandler:

    @staticmethod
    def get_token(user: User) -> str:
        """Sets the token's necessary properties."""
        payload = {
            "id": user.id,
            "exp": datetime.datetime.now(datetime.timezone.utc)
                   + datetime.timedelta(minutes=60),
            "iat": datetime.datetime.now(datetime.timezone.utc),
        }

        return jwt.encode(payload=payload, key="secret", algorithm="HS256")

    @staticmethod
    def check_user_authenticity(user, password) -> None:
        """Checks if the user authenticated or not"""
        if not user:
            raise AuthenticationFailed("Username doesn't exist.")

        if not user.check_password(password):
            raise AuthenticationFailed("Password isn't correct.")

    def get_response_structure(self, user: User, cookie_key: str = "") -> Response:
        """Returns all response properties combined."""
        token = self.get_token(user)
        response = Response()
        response.set_cookie(key=cookie_key, value=token, httponly=True)
        response.data = {
            "jwt": token,
        }
        return response

    def sign_in(self, request, role) -> Response:
        """Handles the sign-in process of all roles."""
        username = request.data.get("username")
        password = request.data.get("password")
        user = RoleFactory().get_user_instance(username=username, role=role)
        self.check_user_authenticity(user=user, password=password)
        return self.get_response_structure(user=user, cookie_key="jwt")


class MechanicSignInView(APIView):

    @staticmethod
    def post(request) -> Response:
        """Handles the mechanics login POST requests."""
        return SignInHandler().sign_in(request=request, role="mechanic")


class ClientSignInView(APIView):

    @staticmethod
    def post(request) -> Response:
        """Handles the clients login POST requests."""
        return SignInHandler().sign_in(request=request, role="client")


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
