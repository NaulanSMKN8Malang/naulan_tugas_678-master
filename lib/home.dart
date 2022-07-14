import 'package:flutter/material.dart';
import 'package:naulan_tugas_678/authentication.dart';
import 'package:naulan_tugas_678/login.dart';
import 'package:naulan_tugas_678/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naulan_tugas_678/productCard.dart';
import 'package:naulan_tugas_678/repository/DataRepository.dart';
import 'package:naulan_tugas_678/transaction/addProduct.dart';

class HomeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  DataRepository repository = DataRepository();
  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        leading: IconButton(
            onPressed: () {
              AuthenticationHelper()
                  .signOut()
                  .then((_) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      ));
            },
            icon: Icon(Icons.logout)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data?.docs ?? []);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push<Widget>(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
        icon: Icon(Icons.add),
        label: Text("New Product"),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    var product = Product.fromSnapshot(snapshot);
    return ProductCard(product: product);
  }
}
