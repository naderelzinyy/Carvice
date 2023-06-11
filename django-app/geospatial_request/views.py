
from rest_framework.response import Response
from rest_framework.views import APIView

from .mongo_configuration import db


class AddMechanicLocation(APIView):
    @staticmethod
    def post(request) -> Response:
        """Handles adding mechanics locations."""
        print(f"{request.data = }")
        try:
            db.mechanics.insert_one(request.data)
            return Response({"success_message": "location added successfully."})
        except Exception as e:
            print(f"{e = }")
            return Response({"failure_message": "Couldn't add the location."})


class GetAvailableMechanics(APIView):
    @staticmethod
    def post(request) -> Response:
        """Handles fetching mechanics in a specific area based on the coordinates passed in the requests."""
        print(f"{request.data = }")
        try:
            coordinates = request.data.get("coordinates")
            print(f"{coordinates = }")
            query = {
                "location": {
                    "$near": {
                        "$geometry": {
                            "type": "Point",
                            "coordinates": coordinates
                        },
                        "$maxDistance": 10500
                    }
                }
            }
            available_mechanics = list(db.mechanics.find(query, {'_id': False}))
            print(f"after find {type(available_mechanics)}")
            return Response({"available_mechanics": available_mechanics})
        except Exception as e:
            print(f"{e = }")
            return Response({"failure_message": "Couldn't fetch mechanics locations."})


class UpdateMechanicInfo(APIView):
    pass
