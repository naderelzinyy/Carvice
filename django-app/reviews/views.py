from rest_framework.response import Response
from rest_framework.views import APIView
from .serializers import ReviewSerializer
from .serializers import mechanic, client
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
    def __add_client_name_to_review(review) -> list:
        """Adds client names to each review"""

        client_instance = client.objects.get(id=int(review["client_id"]))
        review["client_name"] = f"{client_instance.first_name} {client_instance.last_name}"
        return review

    @staticmethod
    def __generate_rate_list(review_list) -> list:
        """Returns rate list"""

        rate_list = [0, 0, 0, 0, 0]
        for review in list(review_list):
            rate_list[int(review["rate"]) - 1] += 1
            # [1, 2, 3, 4, 5]
            #  0  1  2  3  4  => Rating
        return rate_list

    def post(self, request) -> Response:
        print(f"{request.data = }")
        mechanic_id = request.data.get("mechanic_id")
        mechanic_instance = mechanic.objects.get(account_id=int(mechanic_id))
        if review_list := Review.objects.filter(mechanic_id=mechanic_instance).values():
            review_list = [self.__add_client_name_to_review(review) for review in review_list]
            rate_list = self.__generate_rate_list(review_list)
            avg = ((rate_list[0] * 1) + (rate_list[1] * 2) + (rate_list[2] * 3) + (rate_list[3] * 4) + (
                    rate_list[4] * 5)) / sum(rate_list)

            print(f"{list(review_list) = }")
            return Response({"reviews": review_list, "rate_list": rate_list, "average": avg})
        return Response({"reviews": [], "rate_list": [], "average": 0})
