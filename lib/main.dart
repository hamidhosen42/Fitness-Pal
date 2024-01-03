import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/colo_extension.dart';
import 'view/on_boarding/started_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          title: 'Fitness',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: TColor.primaryColor1, fontFamily: "Poppins"),
          home: const StartedView(),
        );
      },
    );
  }
}