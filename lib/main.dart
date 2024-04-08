import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productsapp/firebase_options.dart';
import 'package:productsapp/pages/auth_page.dart';
import 'package:productsapp/pages/home_page.dart';
import 'package:productsapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';
import './pages/add_product_page.dart';
import './pages/edit_product_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProxyProvider<AuthProvider, Products>(
              create: (context) => Products(),
              update: (context, auth, products) => products!..updateData(auth.token, auth.userId),
          ),
        ],
        builder: (context, child) => Consumer<AuthProvider>(
              builder: (context, auth, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.white)
                  )
                ),
                home: auth.isAuth ? const HomePage() : const AuthPage(),
                routes: {
                  AddProductPage.route: (context) => AddProductPage(),
                  EditProductPage.route: (context) => const EditProductPage(),
                },
              ),
            ));
  }
}
