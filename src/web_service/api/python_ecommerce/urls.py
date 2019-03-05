#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
Create urls for every end point in the API.
"""
from django.urls import path

from .views import CustomerListView, OrdersListView, ProductListView, OrdersDetailListView, OrdersInformationListView

urlpatterns = [
    path('customers/', CustomerListView.as_view(), name="customer-all"),
    path('orders/', OrdersListView.as_view(), name="orders-all"),
    path('orders-detail/', OrdersDetailListView.as_view(), name="orders-all"),
    path('orders-information/', OrdersInformationListView.as_view(), name="orders-information-all"),
    path('products/', ProductListView.as_view(), name="product-all"),
]
