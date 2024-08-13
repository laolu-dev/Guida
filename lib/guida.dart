import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routes.dart';
import 'constants/color.dart';
import 'util/helpers.dart';

class GuidaApp extends ConsumerWidget {
  final String initialRoute;
  const GuidaApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      designSize: const Size(395, 896),
      builder: (context, _) {
        return MaterialApp(
          title: 'Guida',
          theme: ThemeData(
            fontFamily: "Montserrat",
            colorScheme: ColorScheme.fromSeed(seedColor: GuidaColors.red),
            useMaterial3: true,
          ),
          initialRoute: initialRoute,
          navigatorKey: ref.watch(navigatorKey),
          onGenerateRoute: GuidaRoutes.routeGenerator,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
