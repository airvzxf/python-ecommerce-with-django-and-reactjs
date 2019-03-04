#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
Registers the models which should be show in the Admin web site.
"""

from django.contrib import admin

from api.python_ecommerce.models import AppCustomer, AppOrders, AppOrdersDetail, AppProduct

admin.site.register(AppCustomer)
admin.site.register(AppOrders)
admin.site.register(AppOrdersDetail)
admin.site.register(AppProduct)
