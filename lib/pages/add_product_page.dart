// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../providers/products.dart';

class AddProductPage extends StatelessWidget {
  static const route = "/add-product";

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    void save(String title, String price) {
      try {
        Provider.of<Products>(context, listen: false)
            .addProduct(title, price)
            .then((value) async {
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pop(context);
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Berhasil Menambahkan Product!',
          );
        });
      } catch (err) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error Occured"),
              content: Text("Error : $err"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Okay"))
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Product",
          style: TextStyle(
            fontFamily: "Roboto-Bold",
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => save(titleController.text, priceController.text),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  autocorrect: false,
                  autofocus: true,
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Product Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  autocorrect: false,
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: () =>
                    save(titleController.text, priceController.text),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                      fontFamily: "Roboto-Bold",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 2,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
