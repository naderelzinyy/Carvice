import datetime
from typing import Union, Any

import jwt

from rest_framework.response import Response
from rest_framework.exceptions import AuthenticationFailed
from rest_framework.views import APIView
from .serializers import UserSerializer, CarSerializer, MechanicSerializer, ClientSerializer
from django.contrib.auth import get_user_model
from .models import Car

# Create your views here.
User = get_user_model()


class SignUpHandler:

    def __init__(self):
        self.role_directors = {
            "mechanic": self.sign_up_mechanic,
            "client": self.sign_up_client,
        }

    @staticmethod
    def save_user(request) -> tuple[Response, Any]:
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data), serializer.data

    @staticmethod
    def sign_up_mechanic(request) -> None:
        serializer = MechanicSerializer(data=request)
        serializer.is_valid(raise_exception=True)
        serializer.create(validated_data=request)

    @staticmethod
    def sign_up_client(request) -> None:
        print(f"{request = }")
        try:
            serializer = ClientSerializer(data=request)
            serializer.is_valid(raise_exception=True)
            serializer.create(validated_data=request)
        except Exception as e:
            print(f"{e = }")


class SignupView(APIView):

    @staticmethod
    def post(request) -> Response:
        """Handles the registration POST requests."""
        role = "client" if int(request.data.get("is_client")) else "mechanic"
        print(f"{role = }")
        response, serialized_data = SignUpHandler.save_user(request=request)
        # save to client or mechanic table.
        if role == "client":
            modified_request = {
                                "account_id": serialized_data.get("id"),
                                "first_name": serialized_data.get("first_name"),
                                "last_name": serialized_data.get("last_name")}
        else:
            print("inside else")
            modified_request = {
                                "account_id": serialized_data.get("id"),
                                "first_name": serialized_data.get("first_name"),
                                "last_name": serialized_data.get("last_name"),
                                "commercial_name": request.data.get("commercial_name")}

        signup_action = SignUpHandler().role_directors.get(role)
        print(f"{signup_action = }")
        signup_action(request=modified_request)
        return response


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


class Tokenizer:
    @staticmethod
    def get_token(user: User) -> str:
        """Sets the token's necessary properties."""
        payload = {
            "id": user.id,
            "first_name": user.first_name,
            "last_name": user.last_name,
            "username": user.username,
            "phone_number": str(user.phone_number),
            "email": user.email,
            "exp": datetime.datetime.now(datetime.timezone.utc)
                   + datetime.timedelta(minutes=60),
            "iat": datetime.datetime.now(datetime.timezone.utc),
        }

        return jwt.encode(payload=payload, key="secret", algorithm="HS256")


class SignInHandler:

    @staticmethod
    def check_user_authenticity(user, password) -> None:
        """Checks if the user authenticated or not"""
        if not user:
            raise AuthenticationFailed("Username doesn't exist.")

        if not user.check_password(password):
            raise AuthenticationFailed("Password isn't correct.")

    def get_response_structure(self, user: User, cookie_key: str = "") -> Response:
        """Returns all response properties combined."""
        token = Tokenizer.get_token(user)
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


class UpdateUserInfo(APIView):
    @staticmethod
    def post(request) -> Union[str, Response]:
        print(f"update post :: {request.data = }")
        try:
            user = User.objects.get(id=request.data.get("id"))
            user.first_name = request.data.get("first_name")
            user.last_name = request.data.get("last_name")
            user.username = request.data.get("username")
            user.email = request.data.get("email")
            user.phone_number = request.data.get("phone_number")
            user.save()
            response = Response()
            response.data = {
                "jwt": Tokenizer.get_token(user),
            }
            return response
        except Exception as e:
            print(f"Failure due to the following exception :: {e}")
            return Response({"message": "failure"})


class AddCar(APIView):
    @staticmethod
    def post(request) -> Response:
        print(f"{request.data = }")
        serializer = CarSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save(validated_data=request.data)
        return Response(serializer.error_response or serializer.data)


class GetCars(APIView):
    @staticmethod
    def post(request) -> Response:
        print(f"{request.data = }")
        user_id = request.data.get("user_id")
        user = User.objects.get(id=int(user_id))
        car_list = Car.objects.filter(owner_id=user).values()
        print(f"{car_list = }")
        return Response({"cars": car_list})


class UpdateCarInfo(APIView):
    @staticmethod
    def post(request) -> Union[str, Response]:
        print(f"update post :: {request.data = }")
        try:
            car = Car.objects.get(id=request.data.get("car_id"))
            car.owner = request.data.get("owner", car.owner)
            car.plate_number = request.data.get("plate_number", car.plate_number)
            car.brand = request.data.get("brand", car.brand)
            car.series = request.data.get("series", car.series)
            car.model = request.data.get("model", car.model)
            car.year = request.data.get("year", car.year)
            car.fuel = request.data.get("fuel", car.fuel)
            car.engine_power = request.data.get("engine_power", car.engine_power)
            car.save()
            return Response(data={"message": "success"})
        except Exception as e:
            print(f"Failure due to the following exception :: {e}")
            return Response(data={"message": "failure"})


class DeleteCar(APIView):
    @staticmethod
    def post(request) -> Response:
        print(f"{request.data = }")
        try:
            Car.objects.get(id=int(request.data.get("car_id"))).delete()
            return Response({"message": "success"})
        except Exception as e:
            return Response({"message": "failure"})
