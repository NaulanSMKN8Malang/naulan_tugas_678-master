import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:naulan_tugas_678/model/trans_model.dart';

class TransRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('transaction');
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addTransaction(Transactions transaction) {
    return collection.add(transaction.toJson());
  }
}
