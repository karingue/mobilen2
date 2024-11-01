import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:mobilen2/providers/wishlist_provider.dart';
import 'package:mobilen2/screens/wishlist_screen.dart';
import 'package:mobilen2/app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( // Inicializa o Banco de Dados
    options: DefaultFirebaseOptions.currentPlatform, // Importa a configuração da página options
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
