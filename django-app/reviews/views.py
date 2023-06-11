from rest_framework.response import Response
from rest_framework.views import APIView
from .serializers import ReviewSerializer
from .serializers import mechanic
from .models import Review


class AddReview(APIView):

    @staticmethod
    def post(request) -> Response:
        """Handles the view's post requests."""
        print(f"{request.data = }")
        serializer = ReviewSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save(validated_data=request.data)
        return Response(serializer.error_response or serializer.data)


class GetReviews(APIView):

    @staticmethod
    def post(request) -> Response:
        print(f"{request.data = }")
        mechanic_id = request.data.get("mechanic_id")
        mechanic_instance = mechanic.objects.get(id=int(mechanic_id))
        review_list = Review.objects.filter(mechanic_id=mechanic_instance).values()
        print(f"{review_list = }")
        return Response({"reviews": review_list})
