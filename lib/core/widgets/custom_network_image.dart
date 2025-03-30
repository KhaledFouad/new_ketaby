import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_ketaby/config/icons/icons_broken.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/core/utils/app_constants.dart';

class CustomNetworkImage extends StatelessWidget {
  final double borderRadius;
  final String image;

  final Color textColor;
  final BoxFit boxfit;
  const CustomNetworkImage({
    super.key,
    required this.borderRadius,
    required this.image,
    required this.textColor,
    required this.boxfit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: AppColors.white,
          ),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: boxfit,
            // height: double.infinity,
            errorWidget:
                (context, url, error) => Icon(
                  IconBroken.Info_Square,
                  color: AppColors.primaryColor,
                  size: AppConstants.iconSize24,
                ),
          ),
        ),
      ],
    );
  }
}
