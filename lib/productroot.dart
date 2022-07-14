import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:naulan_tugas_678/home.dart';

class Product extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Inventori', home: Main());
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produk'),
      ),
      //body: Center(
      //  child: Text('Halaman Produk')
      //),
      body: CupertinoScrollbar(
        thickness: 8,
        isAlwaysShown: true,
        child: ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: ListTile(
                  leading: Image.network(
                    "https://m.media-amazon.com/images/I/81MIfjXl3mL._AC_UX500_.jpg",
                  ),
                  trailing: Icon(Icons.delete),
                  title: Text(
                    "Sepatu baru",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "SH-231",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeList(),
                ));
          },
          icon: Icon(Icons.add),
          label: Text("Tambah")),
    );
  }
}
