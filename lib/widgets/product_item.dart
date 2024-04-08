// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../providers/products.dart';
import '../pages/edit_product_page.dart';

class ProductItem extends StatelessWidget {
  final String id, title, price;

  final DateTime updatedAt;

  const ProductItem(this.id, this.title, this.price, this.updatedAt,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Products>(context, listen: false);
    String date = DateFormat.yMMMd().add_Hms().format(updatedAt);
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, EditProductPage.route, arguments: id);
      },
      leading: CircleAvatar(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: FittedBox(
            child: Text("\$$price"),
          ),
        ),
      ),
      title: Text(title),
      subtitle: Text("Last Edited : $date"),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Delete!"),
                content: const Text("Hapus Product?"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent),
                    child: const Text("Tidak",
                        style: TextStyle(color: Colors.white)),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      prov.deleteProduct(id);
                      await Future.delayed(const Duration(seconds: 2));
                      Navigator.pop(context);
                      await QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Berhasil Hapus Product!',
                      );
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent),
                    child: const Text(
                      "Ya",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
