from rest_framework.response import Response
from rest_framework.views import APIView
from .serializers import UserSerializer
# Create your views here.


class SignupView(APIView):

    @staticmethod
    def post(request) -> Response:
        """Handles sending POST requests."""
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)
