import 'package:flutter/material.dart';
import 'package:naulan_tugas_678/model/product.dart';
import 'package:naulan_tugas_678/repository/DataRepository.dart';

class AddProduct extends StatelessWidget {
  final inputProductId = TextEditingController();
  final inputProductName = TextEditingController();
  final inputPrice = TextEditingController();
  final inputStock = TextEditingController();
  final inputDescription = TextEditingController();

  DataRepository repository = DataRepository();
  late Product product;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Product Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Product Image",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    height: 200,
                    child: Center(
                      child: Icon(Icons.add, size: 50, color: Colors.blue),
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      border: Border.all(width: 5, color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Text("Product Name",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      controller: inputProductName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Adidas, Balenciaga",
                      ),
                    ),
                  ),
                  Text("Product Id",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      controller: inputProductId,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "SH-101",
                      ),
                    ),
                  ),
                  Text("Price",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      controller: inputPrice,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "1000000",
                      ),
                    ),
                  ),
                  Text("Stock",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      controller: inputStock,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "10",
                      ),
                    ),
                  ),
                  Text("Description",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      controller: inputDescription,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Description",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ))),
                        onPressed: () {
                          Navigator.pop(context);
                          product = new Product(
                              inputProductName.text,
                              double.parse(inputPrice.text),
                              int.parse(inputStock.text),
                              inputDescription.text,
                              inputProductId.text);
                          repository.addProduct(product);
                        },
                        child: Text("Add Product")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
