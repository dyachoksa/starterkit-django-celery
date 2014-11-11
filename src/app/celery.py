# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals
import os
from celery import Celery
from django.conf import settings


# set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'app.settings.development')

celery_app = Celery('app')

celery_app.config_from_object('django.conf:settings')
celery_app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)


@celery_app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))
