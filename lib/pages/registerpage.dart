// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app_assignment/pages/loginpage.dart';
import 'package:e_commerce_app_assignment/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'),
      ),

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
          const SizedBox(height: 10,),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password'
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: confirmPasswordController,
            decoration: const InputDecoration(
              labelText: 'Confirm Password'
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async{
            if(passwordController.text != confirmPasswordController.text){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password doesn\'t match')));
              return;

            }
            User? user = await _auth.registerWithEmailAndPassword(emailController.text, passwordController.text);
           
            if(user!=null){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration Successful')));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration Failed')));
            }
          },
          child: Text('Register', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
          ),
          const SizedBox(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("already have an account?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary
                ),
                ),
                const SizedBox(width: 2),
                TextButton(onPressed: (){
                  Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            }, 
            child: const Text('Login'),
            ),
              ],
            )

          ],
        ),
      ),
    );
  }
}