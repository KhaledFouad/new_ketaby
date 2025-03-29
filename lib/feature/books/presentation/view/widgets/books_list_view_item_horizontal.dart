import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ketaby/config/routes/app_routes.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/core/utils/app_constants.dart';
import 'package:new_ketaby/core/utils/app_styles.dart';
import 'package:new_ketaby/core/widgets/custom_network_image.dart';
import 'package:new_ketaby/feature/books/data/model/news/article.dart';

class BooksListViewItemHorizontal extends StatelessWidget {
  const BooksListViewItemHorizontal({
    super.key,
    required this.book,
    required this.index,
  });

  final Article book;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.bookDetailsView, arguments: book);
      },
      child: Container(
        padding: EdgeInsets.all(AppConstants.padding10h),
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(AppConstants.radius8sp),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: CustomNetworkImage(
                borderRadius: AppConstants.radius8sp,
                image: book.urlToImage!,
                color: AppColors.primaryColor.withOpacity(0.9),
                textColor: AppColors.white,
                boxfit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.only(left: AppConstants.padding10w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            book.title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppStyles.textStyle18.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      book.source!.name!,
                      style: AppStyles.textStyle15.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'EGP ${double.parse(book.price!) - double.parse(book.price!) * book.discount! / 100}  ',
                    //       style: AppStyles.textStyle14.copyWith(
                    //         color: AppColors.primaryColor,
                    //       ),
                    //     ),
                    //     Text(
                    //       'EGP ${book.price}',
                    //       style: AppStyles.textStyle12.copyWith(
                    //         color: AppColors.grey,
                    //         decoration: TextDecoration.lineThrough,
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
