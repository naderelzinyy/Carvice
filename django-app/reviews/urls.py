
from django.urls import path
from .views import GetReviews, AddReview

urlpatterns = [
    path('getReviews', GetReviews.as_view()),
    path('addReview', AddReview.as_view()),

]
