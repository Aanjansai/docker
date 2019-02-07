from django.urls import path, re_path
from chat.views import index, room           # importing views from current directory

app_name = 'chat'

urlpatterns = [
    path('', index, name="index"),
    re_path(r'^(?P<room_name>[^/]+)/$', room, name='room'),
]
