#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
Create views for the API calls.
"""
from rest_framework import generics

from api.python_ecommerce.serializers import CustomerSerializer
from .models import AppCustomer


class ListCustomerView(generics.ListAPIView):
    """
    Provides a get method handler.
    """
    queryset = AppCustomer.objects.all()
    serializer_class = CustomerSerializer
