#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
Create the models using in the API.
"""
# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AppCustomer(models.Model):
    """
    Customer model class.
    """
    id_app_customer = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=45)
    last_name = models.CharField(max_length=45)
    email = models.CharField(unique=True, max_length=100)

    class Meta:
        managed = False
        db_table = 'app_customer'


class AppOrders(models.Model):
    """
    Orders model class.
    """
    id_app_orders = models.AutoField(primary_key=True)
    id_app_customer = models.ForeignKey(AppCustomer, models.DO_NOTHING, db_column='id_app_customer')
    utc_date = models.DateTimeField(blank=True, null=True)
    total = models.DecimalField(max_digits=20, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_orders'
        unique_together = (('id_app_orders', 'id_app_customer'),)


class AppProduct(models.Model):
    """
    Product model class.
    """
    id_app_product = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    sku = models.CharField(unique=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'app_product'


class AppOrdersDetail(models.Model):
    """
    Orders detail model class.
    """
    id_app_orders_detail = models.AutoField(primary_key=True)
    id_app_orders = models.ForeignKey(AppOrders, models.DO_NOTHING, db_column='id_app_orders')
    id_app_customer = models.ForeignKey(AppCustomer, models.DO_NOTHING, db_column='id_app_customer')
    id_app_product = models.ForeignKey(AppProduct, models.DO_NOTHING, db_column='id_app_product')
    price = models.DecimalField(max_digits=20, decimal_places=2, blank=True, null=True)
    quantity = models.PositiveIntegerField()

    class Meta:
        managed = False
        db_table = 'app_orders_detail'
        unique_together = (('id_app_orders_detail', 'id_app_orders', 'id_app_customer', 'id_app_product'),)
