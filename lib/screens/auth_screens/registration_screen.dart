import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/password_text_form_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late bool _isCreateAccountInProgress;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _isCreateAccountInProgress = false;
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter email.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
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
                  onPressed: _isCreateAccountInProgress == false
                      ? null
                      : () {
                          if (_formKey.currentState!.validate() == true) {
                            createUser(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                            );
                          }
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
      ),
    );
  }

  Future<void> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    _isCreateAccountInProgress = true;
    if (mounted) {
      setState(() {});
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // log(userCredential.user.toString());
      _isCreateAccountInProgress = false;
      if (mounted) {
        setState(() {});
      }
      showToastMessage('Account create completed.');
      _formKey.currentState!.reset();
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.sendEmailVerification();
      showToastMessage('Account activation URL has been sent to your email.');
    } on FirebaseAuthException catch (e) {
      if (e.code.contains('weak-password') == true) {
        // log('The password provided is too weak.');
        showToastMessage(
          'The password provided is too weak.',
          color: Colors.red,
        );
      } else if (e.code.contains('email-already-in-use') == true) {
        // log('The account already exists for that email.');
        showToastMessage(
          'The account already exists for that email.',
          color: Colors.red,
        );
      }
    } catch (e) {
      log(e.toString());
      showToastMessage(
        e.toString(),
        color: Colors.red,
      );
    }
    _isCreateAccountInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  void showToastMessage(String content, {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(content),
      ),
    );
  }
}
