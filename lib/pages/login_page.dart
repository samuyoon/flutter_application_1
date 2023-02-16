import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<String?> userLogin({
    required final String email,
    required final String password,
  }) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
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
      appBar: AppBar(title: const Text('Sign In')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Login below'),
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              dynamic _loginValue = await userLogin(
                email: _emailController.text, 
                password: _passwordController.text);
              setState(() {
                _isLoading = false;
              });
              if (_loginValue != null) {
                Navigator.pushReplacementNamed(
                  context, 
                  '/homepage',
                  );
              } else {
                context.showErrorSnackBar(message: 'Invalid email or password');
              }
            },
            child: Text(_isLoading ? 'Loading' : 'Sign In'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(
              context, 
              '/signup'), 
            child: Text('Sign Up'))
        ],
      ),
    );
  }
}