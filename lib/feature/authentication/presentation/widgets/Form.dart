import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/core/widgets/custom_text_field.dart';
import 'package:new_ketaby/core/widgets/customText.dart';
import 'package:new_ketaby/core/widgets/gradient_button.dart';

class AuthForm extends StatefulWidget {
  final bool isLogin;
  final Function(String email, String password) onSubmit;
  final Function()? onToggleAuthMode;
  final TextEditingController? usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? confirmpasswordController;

  final GlobalKey<FormState> formKey;

  const AuthForm({
    super.key,
    required this.isLogin,
    required this.onSubmit,
    this.onToggleAuthMode,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    this.confirmpasswordController,
    this.usernameController,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool visible = true;
  bool visible2 = true;
  bool valid1 = false;
  bool valid2 = false;
  bool valid3 = false;
  bool valid4 = false;

  @override
  void initState() {
    super.initState();
    widget.usernameController?.addListener(() {
      setState(() {
        valid1 = widget.usernameController!.text.isNotEmpty;
      });
    });
    widget.emailController.addListener(() {
      setState(() {
        valid2 = widget.emailController.text.isNotEmpty;
      });
    });
    widget.passwordController.addListener(() {
      setState(() {
        valid4 = widget.passwordController.text.length >= 8;
      });
    });
    widget.confirmpasswordController?.addListener(() {
      setState(() {
        valid4 = widget.confirmpasswordController!.text.length >= 8;
      });
    });
  }

  @override
  void dispose() {
    widget.usernameController?.dispose();
    widget.emailController.dispose();
    widget.passwordController.dispose();
    widget.confirmpasswordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          CustomText(
            widget.isLogin ? "Login" : "Register",
            fontSize: 28.sp,
            fontweight: FontWeight.w500,
          ),
          SizedBox(height: 3.h),
          CustomText(
            widget.isLogin
                ? "Welcome back! Nice to see you again"
                : "Create your account",
            fontSize: 15.sp,
            fontweight: FontWeight.w700,
            textColor: AppColors.greenAccent,
          ),
          SizedBox(height: 20.h),
          Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.isLogin
                    ? SizedBox()
                    : CustomTextField(
                      controller: widget.usernameController!,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "UserName",
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        size: 30,
                        color: AppColors.grey500,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Username";
                        }
                        return null;
                      },
                      title: 'UserName',
                      textInputAction: TextInputAction.next,
                    ),
                CustomTextField(
                  controller: widget.emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    size: 30,
                    color: AppColors.grey500,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CustomTextField(
                  controller: widget.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  obscureText: visible,
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    size: 30,
                    color: AppColors.grey500,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                    child: Icon(
                      visible ? Icons.visibility_off : Icons.visibility,
                      size: 20.sp,
                      color: AppColors.grey500,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    return null;
                  },
                  title: 'Password',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                widget.isLogin
                    ? SizedBox()
                    : CustomTextField(
                      controller: widget.confirmpasswordController!,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      obscureText: visible2,
                      hintText: "Confrim Password",
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 30.sp,
                        color: AppColors.grey500,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            visible2 = !visible2;
                          });
                        },
                        child: Icon(
                          visible2 ? Icons.visibility_off : Icons.visibility,
                          size: 20.sp,
                          color: AppColors.grey500,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },
                      title: 'Confrim Password',
                    ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          if (widget.onToggleAuthMode != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  widget.isLogin
                      ? "Don't have an account?"
                      : "Already have an account?",
                  fontSize: 14.sp,
                  textColor: AppColors.grey500,
                  fontweight: FontWeight.w400,
                ),
                SizedBox(width: 0.6.w),
                InkWell(
                  onTap: widget.onToggleAuthMode,
                  child: CustomText(
                    widget.isLogin ? "Register" : "Login",
                    fontSize: 14.sp,
                    textColor: AppColors.greenAccent,
                    fontweight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          SizedBox(height: 20.h),
          GradientButton(
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                widget.onSubmit(
                  widget.emailController.text.trim(),
                  widget.passwordController.text.trim(),
                );
              }
            },
            radius: 1000,
            title: widget.isLogin ? 'Login' : 'Register',
          ),
        ],
      ),
    );
  }
}
