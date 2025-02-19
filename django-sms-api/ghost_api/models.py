from django.db import models

class SMS(models.Model):
    number = models.CharField(max_length=14, null=False)
    content = models.CharField(max_length=14, null=False)
    date = models.CharField(max_length=10, null=False)

    def __str__(self):
        return f'{self.id}: {self.number} {self.content} {self.date}.'