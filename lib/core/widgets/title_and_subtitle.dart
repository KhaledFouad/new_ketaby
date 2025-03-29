import 'package:flutter/material.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/core/utils/app_constants.dart';
import 'package:new_ketaby/core/utils/app_styles.dart';

class TitleAndSubtitle extends StatelessWidget {
  const TitleAndSubtitle({
    super.key,
    required this.subtitle,
    required this.title,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppStyles.textStyle30),
        Padding(
          padding: EdgeInsets.only(bottom: AppConstants.defaultPadding),
          child: Text(
            subtitle,
            style: AppStyles.textStyle16.copyWith(color: AppColors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
