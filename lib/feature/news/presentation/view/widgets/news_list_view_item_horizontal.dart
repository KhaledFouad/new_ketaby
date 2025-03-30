// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/core/utils/app_constants.dart';
import 'package:new_ketaby/core/utils/app_styles.dart';
import 'package:new_ketaby/core/widgets/custom_network_image.dart';
import 'package:new_ketaby/feature/news/data/model/news/article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListViewItemHorizontal extends StatelessWidget {
  const NewsListViewItemHorizontal({
    super.key,
    required this.article,
    required this.index,
  });

  final Article article;
  final int index;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    print(uri);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchURL(article.url!);
      },
      child: Container(
        padding: EdgeInsets.all(AppConstants.padding10h),
        width: double.infinity,
        height: 300.h,
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(AppConstants.radius8sp),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: CustomNetworkImage(
                borderRadius: AppConstants.radius8sp,
                image: article.urlToImage!,
                textColor: AppColors.white,
                boxfit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              flex: 6,
              // child: Padding(
              // padding: EdgeInsets.only(left: AppConstants.padding10w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          article.title!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: AppStyles.textStyle18.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    article.source!.name!,
                    style: AppStyles.textStyle15.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
