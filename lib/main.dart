import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ketaby/config/routes/app_routes.dart';
import 'package:new_ketaby/core/api/api_services_implementation.dart';
import 'package:new_ketaby/feature/books/data/repository/book_repo_implementation.dart';
import 'package:new_ketaby/feature/books/presentation/cubit/books_cubit.dart';
import 'config/themes/app_theme.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => BooksCubit(
                BookRepoImplementation(ApiServicesImplementation()),
              ),
        ),
      ],
      child: const KetabyApp(),
    ),
  );
}

class KetabyApp extends StatelessWidget {
  const KetabyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme(),
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
