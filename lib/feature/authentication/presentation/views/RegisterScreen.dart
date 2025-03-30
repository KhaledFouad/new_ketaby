// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ketaby/config/routes/app_routes.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/core/widgets/customText.dart';
import 'package:new_ketaby/core/widgets/custom_text_field.dart';
import 'package:new_ketaby/core/widgets/gradient_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userNameController = TextEditingController(
    // text: "khaled"
  );
  TextEditingController emailController = TextEditingController(
    // text: "TunA1234@gmail.com"
  );
  TextEditingController passwordController = TextEditingController(
    // text: "TunA12345"
  );
  TextEditingController confirmPasswordController = TextEditingController(
    // text: "TunA12345"
  );
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool visible1 = true;
  bool visible2 = true;
  bool valid1 = false;
  bool valid2 = false;
  bool valid3 = false;
  bool valid4 = false;

  @override
  void initState() {
    super.initState();
    userNameController.addListener(() {
      setState(() {
        valid1 = userNameController.text.isNotEmpty;
      });
    });
    emailController.addListener(() {
      setState(() {
        valid2 = emailController.text.isNotEmpty;
      });
    });

    passwordController.addListener(() {
      if (passwordController.text.length >= 8) {
        setState(() {
          valid3 = passwordController.text.isNotEmpty;
        });
      } else {
        setState(() {
          valid3 = false;
        });
      }
    });
    confirmPasswordController.addListener(() {
      if (confirmPasswordController.text.length >= 8) {
        setState(() {
          valid4 = confirmPasswordController.text.isNotEmpty;
        });
      } else {
        setState(() {
          valid4 = false;
        });
      }
    });
  }

  Future register() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushNamed(context, Routes.homeView);
      var snackBar = SnackBar(
        content: Text(
          "Email created successfully",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.greenAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      var snackBar = SnackBar(
        content: Text(
          "password doesn't match",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (userNameController.text.trim().isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          "Please enter valid username",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (emailController.text.trim().isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          "Please enter valid email",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (!RegExp(
      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[com]",
    ).hasMatch(emailController.text.trim())) {
      var snackBar = SnackBar(
        content: Text(
          "Please Enter Valid as example@gmail.com",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty ||
        valid3 != true ||
        valid4 != true) {
      var snackBar = SnackBar(
        content: Text(
          "Please enter valid password",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
            confirmPasswordController.text.trim() &&
        valid1 & valid2 & valid3 & valid4 == true) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 90,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.loginView);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            const CustomText(
              "Create Account",
              fontSize: 28,
              fontweight: FontWeight.w500,
            ),
            SizedBox(height: 0.8.h),
            CustomText(
              "Welcome! You can register here.",
              fontSize: 16,
              fontweight: FontWeight.w400,
              textColor: AppColors.indigoAccent,
            ),
            const SizedBox(height: 44),
            Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: userNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      hintText: "Username",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        size: 30,
                        color: AppColors.indigoAccent,
                      ),
                      title: 'Username',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[com]",
                        ).hasMatch(value)) {
                          return 'Please Enter Valid as example@gmail.com';
                        }
                        return null;
                      },
                      hintText: "Email",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: 30,
                        color: AppColors.indigoAccent,
                      ),
                      title: 'Email',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      obscureText: visible1 == false ? false : true,
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 30,
                        color: AppColors.indigoAccent,
                      ),
                      onChanged: (p0) {
                        setState(() {
                          visible1 = true;
                        });
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            visible1 = !visible1;
                          });
                        },
                        child: Icon(
                          visible1 == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 30,
                          color: AppColors.indigoAccent,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            passwordController.text.length >= 8) {
                          return "please enter valid password";
                        }
                        return null;
                      },
                      title: '',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      obscureText: visible2 == false ? false : true,
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 30,
                        color: AppColors.indigoAccent,
                      ),
                      onChanged: (p0) {
                        setState(() {
                          visible2 = true;
                        });
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            visible2 = !visible2;
                          });
                        },
                        child: Icon(
                          visible2 == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 30,
                          color: AppColors.indigoAccent,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            passwordController.text.length >= 8) {
                          return "please enter valid password";
                        }
                        return null;
                      },
                      title: '',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    CustomText(
                      "Password must be at least 8 characters",
                      fontSize: 14,
                      textColor:
                          valid3 & valid4
                              ? AppColors.greenAccent
                              : AppColors.indigoAccent,
                      fontweight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  "Already have an account?",
                  fontSize: 14,
                  textColor: AppColors.indigoAccent,
                  fontweight: FontWeight.w500,
                ),
                SizedBox(width: 3.w),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.loginView);
                  },
                  child: CustomText(
                    "login",
                    fontSize: 14,
                    textColor: AppColors.deepPurpleAccent,
                    fontweight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            GradientButton(
              onPressed: () {
                register();
              },
              radius: 1000,
              title: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
