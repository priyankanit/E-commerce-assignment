import 'package:e_commerce_app_assignment/firebase_options.dart';
import 'package:e_commerce_app_assignment/pages/cartpage.dart';
import 'package:e_commerce_app_assignment/pages/homepage.dart';
import 'package:e_commerce_app_assignment/pages/loginpage.dart';
import 'package:e_commerce_app_assignment/pages/product_detail_page.dart';
import 'package:e_commerce_app_assignment/pages/registerpage.dart';
import 'package:e_commerce_app_assignment/providers/provider.dart';
import 'package:e_commerce_app_assignment/services/auth/auth_service.dart';
import 'package:e_commerce_app_assignment/services/auth/login_or_register.dart';
import 'package:e_commerce_app_assignment/themes/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> ProductProvider()),
      ChangeNotifierProvider(create: (context)=> CartProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      StreamProvider<User?>.value(value: AuthService().user, initialData: null,)
    ],
    child: const MyApp()
    ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: '/',
      routes: {
        '/':(context)=> const AuthWrapper(),
        '/home':(context) =>const HomePage(),
        '/login':(context) => const LoginPage(),
        '/register':(context) => const RegisterPage(),
        '/product':(context) => const ProductDetailPage(),
        '/cart':(context) => const CartPage(),
      },
    );
  }
  }

class AuthWrapper extends StatelessWidget {
   const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return const LoginOrRegister();
    } else {
      return const HomePage();
    }
  }
}