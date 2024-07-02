import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/routes.dart';
import 'constants/color.dart';
import 'util/helpers.dart';

class GuidaApp extends ConsumerStatefulWidget {
  const GuidaApp({super.key});

  @override
  ConsumerState<GuidaApp> createState() => _GuidaAppState();
}

class _GuidaAppState extends ConsumerState<GuidaApp> {
  String? _initialRoute;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _initialRoute = prefs.getString("initRoute");
        debugPrint(_initialRoute);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          initialRoute: _initialRoute,
          navigatorKey: ref.watch(navigatorKey),
          onGenerateRoute: GuidaRoutes.routeGenerator,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
