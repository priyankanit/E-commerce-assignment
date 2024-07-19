import 'package:e_commerce_app_assignment/pages/registerpage.dart';
import 'package:e_commerce_app_assignment/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

 const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text('Login'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email'
              ),
            ),
            const SizedBox(height: 10),
             TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
           const  SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async {
              User? user = await _auth.signInWithEmailAndPassword(emailController.text, 
              passwordController.text);
              if(user!= null){
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, '/home');
              }else{
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Email or Password')));
              }
            }, 
            child:  Text('Login', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary
                ),
                ),
                const SizedBox(width: 1,),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
            }, 
            child: const Text('Register'),
            ),
          ],
        ),
          ],
      ),
      ),

    );
  }
}