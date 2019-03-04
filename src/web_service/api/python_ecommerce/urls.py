#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
Create urls for every end point in the API.
"""
from django.urls import path

from .views import ListCustomerView

urlpatterns = [
    path('customer/', ListCustomerView.as_view(), name="customer-all"),
]
