import 'package:naulan_tugas_678/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepository {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');

  Stream<QuerySnapshot> getStream() {
    return collectionReference.snapshots();
  }

  void deleteProduct(Product product) async {
    await collectionReference.doc(product.referenceId).delete();
  }

  Future<DocumentReference> addProduct(Product product) {
    return collectionReference.add(product.toJson());
  }

  void updateProduct(Product product) async {
    await collectionReference.doc(product.referenceId).update(product.toJson());
  }
}
