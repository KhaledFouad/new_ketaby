// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ketaby/config/routes/app_routes.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';

import 'package:new_ketaby/feature/authentication/presentation/widgets/Form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Registration successful",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.greenAccent,
        ),
      );

      Navigator.pushReplacementNamed(context, Routes.newsView);
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'email-already-in-use') {
        errorMessage = "This email is already registered";
      } else if (e.code == 'weak-password') {
        errorMessage = "Password is too weak (min 8 characters)";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format";
      } else {
        errorMessage = "Registration failed. Please try again";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage, style: TextStyle(color: AppColors.white)),
          backgroundColor: AppColors.redAccent,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "An unexpected error occurred",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: AuthForm(
        isLogin: false,
        onSubmit: (email, password) => _register(),
        onToggleAuthMode: () {
          Navigator.pushNamed(context, Routes.loginView);
        },
        usernameController: _usernameController,
        confirmpasswordController: _confirmPasswordController,
        emailController: _emailController,
        passwordController: _passwordController,
        formKey: _formKey,
      ),
    );
  }
}
