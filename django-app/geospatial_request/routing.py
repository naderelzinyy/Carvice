from django.urls import re_path
from . import consumers

websocket_urlpatterns = [
    re_path(r'ws/socket/geospatial-server/(?P<mechanic_id>\w+)/$', consumers.RequestConsumer.as_asgi())
]
