import 'package:flutter/material.dart';
import 'package:naulan_tugas_678/model/trans_model.dart';
import 'package:naulan_tugas_678/repository/trans_repository.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AddTransaction extends StatelessWidget {
  String inputProductId = "";
  //final inputType = TextEditingController();
  final inputQuantity = TextEditingController();
  final inputNote = TextEditingController();
  final TransRepository repository = TransRepository();
  late Transactions transactions;
  String inputType = "";
  String inputName = "";
  var proId;
  var proName;
  var setDefaultId = true;
  var setDefaultName = true;

  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Add Transaction'),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.only(top: 20, left: 8),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Transaction Information',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.0, color: Color(0xFFFF000000)),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text('Select Product',
                              style: const TextStyle(fontSize: 15)),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('products')
                                .orderBy('productId')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) return Container();
                              if (setDefaultId) {
                                proId = snapshot.data!.docs[0].get('productId');
                                debugPrint('setDefault make: $proId');
                              }

                              return DropdownButton(
                                isExpanded: true,
                                value: proId,
                                items: snapshot.data!.docs.map((value) {
                                  return DropdownMenuItem(
                                    value: value.get('productId'),
                                    child: Text(
                                        '${inputName = value.get('name')}'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  inputProductId = value.toString();
                                },
                              );
                            },
                          ),
                        ),
                        Text('Type', style: const TextStyle(fontSize: 15)),
                        Container(
                          margin: EdgeInsets.only(bottom: 20, top: 5),
                          child: Center(
                            child: ToggleSwitch(
                              minWidth: MediaQuery.of(context).size.width / 2,
                              initialLabelIndex: 0,
                              totalSwitches: 2,
                              labels: ['In', 'Out'],
                              onToggle: (index) {
                                print('switched index: $index');
                                if (index == 0) {
                                  inputType = "In";
                                } else {
                                  inputType = "Out";
                                }
                              },
                            ),
                          ),
                        ),
                        Text('Quantity', style: const TextStyle(fontSize: 15)),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextField(
                            controller: inputQuantity,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "1",
                            ),
                          ),
                        ),
                        Text('Note', style: const TextStyle(fontSize: 15)),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextField(
                            controller: inputNote,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "ok lah",
                            ),
                          ),
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.red)))),
                              onPressed: () {
                                Navigator.of(context).pop();
                                transactions = new Transactions(
                                    inputProductId,
                                    inputName,
                                    inputType,
                                    int.parse(inputQuantity.text),
                                    inputNote.text);
                                repository.addTransaction(transactions);
                              },
                              child: Text("Add Transaction"),
                            )),
                      ],
                    ),
                  )))),
    );
  }
}
