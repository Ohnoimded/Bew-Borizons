from django.shortcuts import render
from rest_framework import generics, response, status
from django.http import HttpResponse,JsonResponse

import urllib.parse

from .models import EntitiesMaster
from .serializers import EntitiesMasterSerializer

from .fetch_it_pls import fetch_information
from .llm import get_summary


class SaveEntityView(generics.CreateAPIView):
    queryset = EntitiesMaster.objects.all()
    serializer_class = EntitiesMasterSerializer
    
    def get(self, request, *args, **kwargs):
        if request.method == "GET":
            url = request.GET.get('url',None) or kwargs.get('url',None)
            if url:
                existing_entity = EntitiesMaster.objects.filter(url=url).first()
                if existing_entity:
                    summary = get_summary(data=(existing_entity.concert_title,existing_entity.concert_info))
                    return HttpResponse(
                        f"<div><h2>Status Code: {status.HTTP_200_OK}</h2>"
                        f"<h1>Data already exists:</h1> {url} <h2>Here is the summary: </h2><p>{summary}</p></div>",
                        status=status.HTTP_200_OK
                    )
                else:
                    data = fetch_information(url)['event']
                    concert_title = data.get('concert_title')
                    concert_info = data.get('concert_info')

                    EntitiesMaster.objects.create(concert_title=concert_title, concert_info=concert_info, url=url)
                    summary = get_summary(data=data)
                    return HttpResponse(
                        f"<div><h2>Status Code: {status.HTTP_201_CREATED}</h2>"
                        f"<h1>Data fetched and loaded for:</h1> {url} <h2>Here is the summary: </h2><p>{summary}</p></div>",
                        status=status.HTTP_201_CREATED
                    )
                # events = [] 
        
                # for performance in data['event']['performances']:
                #     performance_datetime = performance['date_time']
                #     performance_dow = performance['dow']
                #     venue = performance['venue']

                #     for program in data['event']['programs']:
                #         composer = program['composer']
                #         piece = program['piece']

                #         for artist in data['event']['artists']:
                #             artist_name = artist['name']
                #             artist_role = artist['role']

                #             # print(data['event']['name'], performance_datetime, venue, composer, piece, artist_name, artist_role)

                #             events.append(
                #                 EntitiesMaster(
                #                     concert_title=data['event']['concert_title'],
                #                     performance_datetime=performance_datetime,
                #                     performance_dow = performance_dow,
                #                     venue=venue,
                #                     artist_name=artist_name,
                #                     artist_role=artist_role,
                #                     composer=composer,
                #                     piece=piece,
                #                     url = url
                #                 )
                #             )

                # EntitiesMaster.objects.bulk_create(events)
                # url = urllib.parse.unquote(url)
            return HttpResponse(f"<div><h2>Status Code: {status.HTTP_201_CREATED}</h2><h1>No url, so no data to fetch and load.</h1></div>",status=status.HTTP_400_BAD_REQUEST)
        return HttpResponse(f"<div><h2>Status Code: {status.HTTP_405_METHOD_NOT_ALLOWED}</h2><h1>Method not allowed</h1></div>",status=status.HTTP_405_METHOD_NOT_ALLOWED)



class GetEntityView(generics.RetrieveAPIView):
    queryset = EntitiesMaster.objects.all()
    serializer_class = EntitiesMasterSerializer
    
    def get(self, request, *args, **kwargs):
        if request.method == "GET":
            url = request.GET.get('url',None) or kwargs.get('url',None)
            if url:
                data = EntitiesMaster.objects.get(url=url)
                serializer = self.serializer_class(data)
                return JsonResponse(serializer.data, status=status.HTTP_200_OK)
