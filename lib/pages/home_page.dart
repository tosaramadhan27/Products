// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:productsapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../pages/add_product_page.dart';
import '../widgets/product_item.dart';

class HomePage extends StatefulWidget {
  static const route = "/home";

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (isInit) {
      isLoading = true;
      Provider.of<Products>(context, listen: false).inisialData().then((value) {
        setState(() {
          isLoading = false;
        });
      }).catchError(
        (err) {
          // print(err);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error Occured"),
                content: Text(err.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Okay"),
                  ),
                ],
              );
            },
          );
        },
      );

      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: const Text(
          "All Products",
          style: TextStyle(
            fontFamily: "Roboto-Bold",
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Logout!"),
                  content: const Text("Apakah anda yakin ingin keluar?"),
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
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                        Navigator.of(context).pop();
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
          icon: const Icon(Icons.logout),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, AddProductPage.route),
          ),
        ],
      ),
      body: (isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (prov.allProduct.isEmpty)
              ? const Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: prov.allProduct.length,
                  itemBuilder: (context, i) => ProductItem(
                    prov.allProduct[i].id,
                    prov.allProduct[i].title,
                    prov.allProduct[i].price,
                    prov.allProduct[i].updatedAt,
                  ),
                ),
    );
  }
}
