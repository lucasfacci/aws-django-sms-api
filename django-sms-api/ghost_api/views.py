from django.http import JsonResponse
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
import json

from .models import SMS

@csrf_exempt
def index(request):
    messages = []
    if request.method == 'POST':
        sms = json.loads(request.body)
        SMS(number=sms['number'], content=sms['content'], date=sms['date']).save()
    else:
        smss = SMS.objects.all()
        for i in range(len(smss)):
            sms = {
                'number': smss[i].number,
                'content': smss[i].content,
                'date': smss[i].date
            }
            messages.append(sms)
    return JsonResponse(messages, safe=False)