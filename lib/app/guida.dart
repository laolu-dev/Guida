import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guida/constants/color.dart';
import 'package:guida/constants/routes.dart';
import 'package:guida/src/providers/providers.dart';

class GuidaApp extends ConsumerWidget {
  const GuidaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      designSize: const Size(410, 896),
      builder: (context, _) => MaterialApp(
        title: 'Guida',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: GuidaColors.red),
          useMaterial3: true,
        ),
        initialRoute: ref.watch(routeController),
        onGenerateRoute: GuidaRoutes.routeGenerator,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
