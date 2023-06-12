
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


class GetMechanicAddressInfo(APIView):
    @staticmethod
    def post(request) -> Response:
        """Handles adding mechanics locations."""
        print(f"{request.data = }")
        try:
            result = db.mechanics.find_one({"user_id": request.data.get("user_id")}, {"_id": False})
            print(f"{result = }")
            return Response({"mechanic_info": result})
        except Exception as e:
            print(f"{e = }")
            return Response({"failure_message": "Couldn't find such an address."})


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
    @staticmethod
    def post(request) -> Response:
        """Handles the request passed to UpdateMechanicInfo view."""
        result = db.mechanic.update_one({"user_id": request.data.get("user_id")}, request.data)

        # Check if the document was successfully updated
        if result.modified_count > 0:
            return Response({"message": "Document updated successfully."})
        else:
            return Response({"failure_message": "Document couldn't be updated."})