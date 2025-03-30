import 'package:flutter/material.dart';
import 'package:new_ketaby/config/routes/app_routes.dart';
import 'package:new_ketaby/feature/authentication/data/Repo/authentication_repository_implementation.dart';
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

  void _navigateToRegister() {
    Navigator.pushReplacementNamed(context, Routes.registerView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: AuthForm(
        isLogin: true,
        onSubmit:
            (email, password) =>
                AuthenticationRepositoryImplementation().userLogin(
                  context: context,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
        onToggleAuthMode: _navigateToRegister,
        emailController: _emailController,
        passwordController: _passwordController,
        formKey: _formKey,
      ),
    );
  }
}
