import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String description;
  String name;
  double price;
  String productId;
  int stock;
  String? referenceId;
  Product(this.name, this.price, this.stock, this.description, this.productId,
      {this.referenceId});
  Product.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        stock = json['stock'],
        description = json['description'],
        productId = json['productId'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'stock': stock,
        'description': description,
        'productId': productId
      };

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    final newProduct =
        Product.fromJson(snapshot.data() as Map<String, dynamic>);
    newProduct.referenceId = snapshot.reference.id;
    return newProduct;
  }
}
