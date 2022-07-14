import 'package:flutter/material.dart';
import 'repository/trans_repository.dart';
import 'model/trans_model.dart';

class TransactionCard extends StatelessWidget {
  final Transactions transactions;
  final TransRepository repository = new TransRepository();
  TransactionCard({Key? key, required this.transactions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      child: Row(
        children: <Widget>[
          Image.network(
            "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/7c2fff38-9f89-40f1-bbcf-ffbfaab5adbc/wio-8-road-running-shoes-S6jPM3.png",
            width: 100,
            height: 100,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transactions.name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(transactions.productId),
                Text("Quantity :" + transactions.quantity.toString()),
              ],
            ),
          ),
          if (transactions.type == "In") Icon(Icons.north_east),
          if (transactions.type == "Out") Icon(Icons.north_west),
        ],
      ),
    ));
  }
}
