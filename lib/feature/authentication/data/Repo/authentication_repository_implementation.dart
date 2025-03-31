import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ketaby/config/routes/app_routes.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/feature/authentication/data/Repo/authentication_repository.dart';

class AuthenticationRepositoryImplementation extends AuthenticationRepository {
  AuthenticationRepositoryImplementation();

  @override
  Future<dynamic> userLogin({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
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

  @override
  Future userRegister({
    required BuildContext context,
    required TextEditingController name,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPassword,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
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
}
