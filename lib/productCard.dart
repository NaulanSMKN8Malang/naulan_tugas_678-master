import 'package:flutter/material.dart';
import 'package:naulan_tugas_678/model/product.dart';
import 'package:naulan_tugas_678/repository/DataRepository.dart';
import 'package:naulan_tugas_678/transaction/editProduct.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final DataRepository repository = new DataRepository();
  ProductCard({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Row(
          children: [
            Image.network(
              "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/qwqfyddzikcgc4ozwigp/revolution-5-road-running-shoesszF7CS.png",
              width: 100,
              height: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(product.productId),
                Text("Stock = " + product.stock.toString()),
              ],
            ),
            Spacer(),
            IconButton(
                onPressed: () {
                  repository.deleteProduct(product);
                },
                icon: Image(
                  image: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/128/3096/3096673.png'),
                ))
          ],
        ),
        onTap: () {
          Navigator.push<Widget>(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProduct(product: product)));
        },
      ),
    );
  }
}
