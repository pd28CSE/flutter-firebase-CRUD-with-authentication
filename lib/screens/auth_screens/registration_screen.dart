import 'package:flutter/material.dart';

import '../../widgets/password_text_form_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'user@gmail.com',
                  prefixIcon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter email.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              PasswordTextFormField(
                labelText: 'Password',
                passwordEditingController: _passwordController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter password.';
                  } else if (value!.length < 8) {
                    return 'Password must be at least 8 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              PasswordTextFormField(
                labelText: 'Confirm Password',
                passwordEditingController: _confirmPasswordController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter confirm password.';
                  } else if (value!.length < 8) {
                    return 'Password must be at least 8 characters.';
                  } else if (value != _passwordController.text) {
                    return 'Password and Confirm Password must be match.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() == true) {}
                },
                child: const Text('Create Anncount'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Login'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
