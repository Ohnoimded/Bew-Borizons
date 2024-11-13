from django.urls import include, path, re_path
from .views import GetEntityView, SaveEntityView

urlpatterns = [
    path('save-entity/', SaveEntityView.as_view(), name='save_entity'),
    path('get-entity/', GetEntityView.as_view(), name='get-entity'),
]
