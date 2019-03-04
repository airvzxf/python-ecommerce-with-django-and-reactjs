#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
Serialize the models to handle the fields in the API.
"""
from rest_framework import serializers

from .models import AppCustomer


class CustomerSerializer(serializers.ModelSerializer):
    """
    Customer serializer class.
    """
    class Meta:
        """
        Meta class for Customer serializer class.
        """
        model = AppCustomer
        fields = ('first_name', 'last_name', 'email')
