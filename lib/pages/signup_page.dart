import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<String?> createUser({
    required final String email,
    required final String password,
  }) async {    
    final AuthResponse res = await supabase.auth.signUp(
    email: email,
    password: password,
    );
    final Session? session = res.session;
    final User? user = res.user;
    return user?.id;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up'),),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Sign up with your email and password'),
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'email pls'),
          ),
          const SizedBox(height: 18,),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'password please my good sir'),
          ),
          const SizedBox(height: 18,),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              dynamic _signupValue = await createUser(
                email: _emailController.text, 
                password: _passwordController.text);
              if(_signupValue != null) {
                Navigator.pushReplacementNamed(
                  context, 
                  '/login');
              } else {
                context.showErrorSnackBar(message: 'sign up failed');
              }
            }, 
            child: Text('Create Account'))


        ],
      ),
    );
  }
}