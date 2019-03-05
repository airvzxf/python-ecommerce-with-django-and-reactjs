#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
Serialize the models to handle the fields in the API.
"""
from rest_framework import serializers

from .models import AppCustomer, AppOrders, AppProduct, AppOrdersDetail


class CustomerSerializer(serializers.ModelSerializer):
    """
    Customer serializer class.
    """

    # TODO: Show how to take information from related table.
    # customer_orders = OrdersSerializer(many=True, read_only=True)

    class Meta:
        """
        Meta class for Customer serializer class.
        """
        model = AppCustomer
        fields = ('id_app_customer', 'first_name', 'last_name', 'email', 'customer_orders')
        # fields = "__all__"


class OrdersSerializer(serializers.ModelSerializer):
    """
    Orders serializer class.
    """
    # customer = CustomerSerializer(many=False, read_only=True)

    # customer = serializers.SerializerMethodField()

    # customer = serializers.RelatedField(source='id_app_customer', read_only=True)
    # customer = serializers.RelatedField(source='id_app_customer', queryset=AppCustomer.objects.all())

    # customer = serializers.ReadOnlyField(source='id_app_customer')
    # customer = serializers.ReadOnlyField(source='id_app_customer.last_name')

    class Meta:
        """
        Meta class for Orders serializer class.
        """
        model = AppOrders
        fields = ('id_app_orders', 'id_app_customer', 'utc_date', 'total', 'customer')
        # fields = "__all__"

        expandable_fields = dict(
            customer_field=CustomerSerializer,
        )


class OrdersDetailSerializer(serializers.ModelSerializer):
    """
    Orders serializer class.
    """

    class Meta:
        """
        Meta class for Orders serializer class.
        """
        model = AppOrdersDetail
        # fields = ('id_app_orders_detail', 'id_app_orders', 'id_app_customer', 'id_app_product', 'price', 'quantity')
        fields = "__all__"


class OrdersInformationSerializer(serializers.ModelSerializer):
    """
    Orders Detail serializer class.
    """

    class Meta:
        """
        Meta class for Orders Detail serializer class.
        """
        model = AppOrders
        # fields = ('id_app_orders', 'id_app_customer', 'app_customer', 'utc_date', 'total')
        fields = "__all__"


class ProductSerializer(serializers.ModelSerializer):
    """
    Product serializer class.
    """

    class Meta:
        """
        Meta class for Product serializer class.
        """
        model = AppProduct
        # fields = ('id_app_product', 'name', 'price', 'sku')
        fields = "__all__"
