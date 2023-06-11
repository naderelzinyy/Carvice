from django.db import models


class Review(models.Model):
    comment = models.CharField(max_length=255)
    rate = models.CharField(max_length=255)
    date = models.DateField()
    client = models.ForeignKey("users.Client", on_delete=models.CASCADE)
    mechanic = models.ForeignKey("users.Mechanic", on_delete=models.CASCADE)
