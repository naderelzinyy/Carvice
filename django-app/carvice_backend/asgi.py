"""
ASGI config for carvice_backend project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.1/howto/deployment/asgi/
"""

import os

from django.core.asgi import get_asgi_application
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
from django.apps import apps as project_apps

geo_request = project_apps.get_app_config("geospatial_request")
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'carvice_backend.settings')

application = ProtocolTypeRouter({
    'http': get_asgi_application(),
    'websocket': AuthMiddlewareStack(
        URLRouter(geo_request.websocket_urlpatterns)
    )
})
