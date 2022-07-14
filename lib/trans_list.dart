import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'transaction_card.dart';
import 'model/trans_model.dart';
import 'repository/trans_repository.dart';
import 'transaction/addTransaction.dart';

class TransList extends StatefulWidget {
  const TransList({Key? key}) : super(key: key);
  @override
  _TransListState createState() => _TransListState();
}

class _TransListState extends State<TransList> {
  final TransRepository repository = TransRepository();
  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            return _buildList(context, snapshot.data?.docs ?? []);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addTransaction();
        },
        tooltip: 'Add Transaction',
        icon: const Icon(Icons.add),
        label: Text("New Transaction"),
      ),
    );
  }

  void _addTransaction() {
    Navigator.push<Widget>(
      context,
      MaterialPageRoute(builder: (context) => AddTransaction()),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final transactions = Transactions.fromSnapshot(snapshot);
    return TransactionCard(transactions: transactions);
  }
}
