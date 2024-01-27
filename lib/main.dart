import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:guida/guida.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv
      .load(fileName: ".env")
      .onError((error, stackTrace) => debugPrint(error.toString()));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(child: GuidaApp()),
  );
}
