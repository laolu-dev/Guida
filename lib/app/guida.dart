import 'package:flutter/material.dart';

import 'package:guida/src/bloc/geolocator_bloc.dart';
import 'package:guida/src/views/home.dart';

class GuidaApp extends StatelessWidget {
  const GuidaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      MaterialApp(
        title: 'Guida',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
    
    );
  }
}
