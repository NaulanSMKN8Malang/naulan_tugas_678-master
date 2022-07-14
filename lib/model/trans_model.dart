import 'package:cloud_firestore/cloud_firestore.dart';

class Transactions {
  String productId;
  String name;
  String type;
  int quantity;
  String note;
  String? referenceId;
  Transactions(this.productId, this.name, this.type, this.quantity, this.note,
      {this.referenceId});
  factory Transactions.fromSnapshot(DocumentSnapshot snapshot) {
    final newProduct =
        Transactions.fromJson(snapshot.data() as Map<String, dynamic>);
    newProduct.referenceId = snapshot.reference.id;
    return newProduct;
  }

  Transactions.fromJson(Map<String, dynamic> json)
      : this.productId = json['productId'],
        this.name = json['name'],
        this.type = json['type'],
        this.quantity = json['quantity'],
        this.note = json['note'];
  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'type': type,
        'quantity': quantity,
        'note': note
      };
}
