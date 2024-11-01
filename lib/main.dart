import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'wishlist_provider.dart';
import 'wishlist_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WishlistProvider()..fetchItems(), // Certifique-se de chamar fetchItems aqui
      child: MaterialApp(
        title: 'My Wishlist',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WishlistScreen(),
      ),
    );
  }
}
