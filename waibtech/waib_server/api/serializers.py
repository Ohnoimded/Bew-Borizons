from rest_framework import serializers
from .models import EntitiesMaster


# class PerformanceSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = EntitiesMaster
#         fields = ['performance_datetime', 'performance_dow', 'venue']

# class ArtistSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = EntitiesMaster
#         fields = ['artist_name', 'artist_role']

# class ProgramSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = EntitiesMaster
#         fields = ['composer', 'piece']

# class EventSerializer(serializers.ModelSerializer):
#     performances = PerformanceSerializer(many=True, read_only=True)
#     artists = ArtistSerializer(many=True, read_only=True)
#     programs = ProgramSerializer(many=True, read_only=True)

#     class Meta:
#         model = EntitiesMaster
#         fields = ['concert_title', 'performances', 'artists', 'programs']



# class EntitiesMasterSerializer(serializers.ModelSerializer):
#     performances = PerformanceSerializer(many=True, read_only=True)
#     artists = ArtistSerializer(many=True, read_only=True)
#     programs = ProgramSerializer(many=True, read_only=True)

#     class Meta:
#         model = EntitiesMaster
#         fields = ['concert_title', 'performances', 'artists', 'programs']

class EntitiesMasterSerializer(serializers.ModelSerializer):
    class Meta:
        model = EntitiesMaster
        fields = "__all__"