#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
Create views for the API calls.
"""
from rest_framework import generics

from api.python_ecommerce.serializers import CustomerSerializer, OrdersSerializer, ProductSerializer, \
    OrdersDetailSerializer, OrdersInformationSerializer
from .models import AppCustomer, AppOrders, AppProduct, AppOrdersDetail


class CustomerListView(generics.ListAPIView):
    """
    Provides a get method handler for customer view.
    """
    queryset = AppCustomer.objects.all()
    serializer_class = CustomerSerializer


class OrdersListView(generics.ListAPIView):
    """
    Provides a get method handler for orders view.
    """
    queryset = AppOrders.objects.all()
    serializer_class = OrdersSerializer


class OrdersDetailListView(generics.ListAPIView):
    """
    Provides a get method handler for orders detail view.
    """
    queryset = AppOrdersDetail.objects.all()
    serializer_class = OrdersDetailSerializer


class OrdersInformationListView(generics.ListAPIView):
    """
    Provides a get method handler for orders information view.
    """
    queryset = AppOrders.objects.all()
    serializer_class = OrdersInformationSerializer


class ProductListView(generics.ListAPIView):
    """
    Provides a get method handler for product view.
    """
    queryset = AppProduct.objects.all()
    serializer_class = ProductSerializer
