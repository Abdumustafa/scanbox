import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scanbox/ui/screen/home_screen.dart';

import 'core/router.dart';

class ScanboxApp extends StatelessWidget {
  const ScanboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp.router(
         routerConfig: routerApp,
        title: "ScanBox",
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
