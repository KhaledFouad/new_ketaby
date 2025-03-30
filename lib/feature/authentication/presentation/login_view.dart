import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ketaby/config/routes/app_routes.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/feature/authentication/presentation/widgets/Form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Login success",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.greenAccent,
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.newsView,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'invalid-credential' || e.code == 'user-not-found') {
        errorMessage = "No user found with this email";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format";
      } else {
        errorMessage = "Login failed. Please try again";
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

  void _navigateToRegister() {
    Navigator.pushReplacementNamed(context, Routes.registerView);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: AuthForm(
        isLogin: true,
        onSubmit: (email, password) => _login(),
        onToggleAuthMode: _navigateToRegister,
        emailController: _emailController,
        passwordController: _passwordController,
        formKey: _formKey,
      ),
    );
  }
}
