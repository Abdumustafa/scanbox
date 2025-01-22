import 'package:go_router/go_router.dart';
import 'package:scanbox/test.dart';
import 'package:scanbox/ui/screen/generate_qr_screen.dart';
import 'package:scanbox/ui/screen/home_screen.dart';
import 'package:scanbox/ui/screen/scan_result_screen.dart';
import 'package:scanbox/ui/screen/scan_screen.dart';

final GoRouter routerApp = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    // GoRoute(
    //   path: '/test',
    //   builder: (context, state) => OpenGalleryScreen(),
    // ),
    GoRoute(
      path: '/scanner',
      builder: (context, state) => ScannerScreen(),
    ),
    
    GoRoute(
      path: '/generate',
      builder: (context, state) => GenerateQrScreen(),
    ),
   GoRoute(
      path: '/result',
      builder: (context, state) => ScanResultScreen(result: state.extra as String), // تمرير النتيجة
    ),
  ],
);
