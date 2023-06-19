from django.apps import AppConfig
from . import routing


class GeospatialRequestConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'geospatial_request'
    websocket_urlpatterns = routing.websocket_urlpatterns
