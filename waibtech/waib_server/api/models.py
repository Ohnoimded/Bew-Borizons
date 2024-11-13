from django.db import models

class EntitiesMaster1(models.Model):
    id = models.AutoField(primary_key=True)
    concert_title = models.CharField(max_length=255)
    performance_datetime = models.DateTimeField(null=True)
    performance_dow = models.CharField(max_length=10)
    venue = models.CharField(max_length=255)
    artist_name = models.CharField(max_length=255)
    artist_role = models.CharField(max_length=255, blank=True, null=True)
    composer = models.CharField(max_length=255)
    piece = models.CharField(max_length=255)
    url = models.URLField(max_length=255, default='')

    class Meta:
        db_table = 'EntitiesMaster1'  



# THis json column helps to reduce complexity. We can use DJango ORM for filtering and more. so the above can be ignored. 
class EntitiesMaster(models.Model):
    id = models.AutoField(primary_key=True)
    url = models.URLField(unique=True,max_length=255, default='')
    concert_title = models.CharField(max_length=255)
    concert_info = models.JSONField(default=dict)
    # concert_summary= models.CharField(max_length=255) # I should have added this before finalizing. this will save cpu overhead on repeated queries.
    class Meta:
        db_table = 'EntitiesMaster'  
