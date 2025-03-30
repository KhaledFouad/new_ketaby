import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ketaby/config/routes/app_routes.dart' show Routes;
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/core/widgets/customText.dart' show CustomText;
import 'package:new_ketaby/core/widgets/custom_text_field.dart';
import 'package:new_ketaby/core/widgets/gradient_button.dart';
import 'package:new_ketaby/feature/authentication/presentation/views/RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(
    // text: "TunA1234@gmail.com"
  );
  TextEditingController passwordController = TextEditingController(
    // text: "TunA12345"
  );
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool visible = true;
  bool valid1 = false;
  bool valid2 = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {
        valid1 = emailController.text.isNotEmpty;
      });
    });

    passwordController.addListener(() {
      if (passwordController.text.length >= 8) {
        setState(() {
          valid2 = passwordController.text.isNotEmpty;
        });
      } else {
        setState(() {
          valid2 = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future login() async {
    try {
      if (valid1 && valid2) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        var snackBar = SnackBar(
          content: Text(
            "Login success",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.greenAccent,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushNamed(context, Routes.layout);
      } else {
        var snackBar = SnackBar(
          content: Text(
            "Please enter valid credentials",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.redAccent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
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

      var snackBar = SnackBar(
        content: Text(errorMessage, style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.redAccent,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      var snackBar = SnackBar(
        content: Text(
          "An unexpected error occurred",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.redAccent,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 90,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            const CustomText(
              "Login",
              fontSize: 28,
              fontweight: FontWeight.w500,
            ),
            SizedBox(height: 0.8.h),
            CustomText(
              "Welcome back! Nice to see you again",
              fontSize: 16,
              fontweight: FontWeight.w400,
              textColor: AppColors.indigoAccent,
            ),
            SizedBox(height: 4.4.h),
            Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Email",
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        size: 30,
                        color: AppColors.indigoAccent,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                      title: 'Email',
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      obscureText: visible == false ? false : true,
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 30,
                        color: AppColors.indigoAccent,
                      ),
                      onChanged: (p0) {
                        setState(() {
                          visible = true;
                        });
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        child: Icon(
                          visible == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 30,
                          color: AppColors.indigoAccent,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            passwordController.text.length >= 8) {
                          // setState(() {});
                          return "please enter valid password";
                        }
                        return null;
                      },
                      title: '',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0015,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  "Dont’t have an account?",
                  fontSize: 14,
                  textColor: AppColors.indigoAccent,
                  fontweight: FontWeight.w400,
                ),
                SizedBox(width: 0.6.w),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                        // detectionScreen()
                        // HomeScreen()
                      ),
                    );
                  },
                  child: CustomText(
                    "Register",
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
                login();
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
