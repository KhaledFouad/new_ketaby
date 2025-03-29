import 'package:flutter/material.dart';
import 'package:new_ketaby/config/icons/icons_broken.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/core/utils/app_constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        IconBroken.Arrow___Left_2,
        size: AppConstants.iconSize28,
        color: color ?? AppColors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
