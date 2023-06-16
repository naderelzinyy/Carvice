
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
            return Response({"mechanic_info": result} if result else {"failure_message": "Couldn't find such an address."})
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
            print(f"Available mechanics :: {available_mechanics = }")
            return Response({"available_mechanics": available_mechanics} if available_mechanics else {"failure_message": "Couldn't find mechanics in your area."})
        except Exception as e:
            print(f"{e = }")
            return Response({"failure_message": "Couldn't fetch mechanics locations."})


class UpdateMechanicInfo(APIView):
    @staticmethod
    def post(request) -> Response:
        """Handles the request passed to UpdateMechanicInfo view."""

        try:
            new_data = request.data.get("new_data")
            location = new_data.get("location")
            print(f"{request.data = }")
            update = {
                "$set": {
                    "city": new_data.get("city"),
                    "county": new_data.get("county"),
                    "district": new_data.get("district"),
                    "streetName": new_data.get("streetName"),
                    "streetNumber": new_data.get("streetNumber"),
                    "apartmentNo": new_data.get("apartmentNo"),
                    "location": {
                        "coordinates": location.get("coordinates"),
                        "type": location.get("type")
                    },
                    "commercial_name": new_data.get("commercial_name")
                }
            }
            user_id = int(request.data.get("user_id"))
            print(f"{user_id = }")
            result = db.mechanics.update_one(filter={"user_id": user_id}, update=update, upsert=True)
            updated_doc = db.mechanics.find_one({"user_id": user_id})
            print(f"{updated_doc = }")

            # check if the document was successfully updated
            if result.modified_count > 0:
                return Response({"message": "Document updated successfully."})
            else:
                return Response({"failure_message": "Document couldn't be updated."})
        except Exception as e:
            print(f"{e=}")
