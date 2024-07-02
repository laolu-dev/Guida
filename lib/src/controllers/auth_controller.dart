import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends AutoDisposeAsyncNotifier<User?> {
  @override
  FutureOr<User?> build() => null;

  void login(Map<String, dynamic> payload) async {
    final String email = payload["email"];
    final String password = payload["password"];
    state = const AsyncLoading();

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => state = AsyncData(value.user));
    } on FirebaseAuthException catch (e) {
      state = AsyncError("${e.message}", e.stackTrace ?? StackTrace.current);
    }
  }
}

class CreateAccountNotifier extends AutoDisposeAsyncNotifier<User?> {
  @override
  FutureOr<User?> build() => null;

  void signup(Map<String, dynamic> payload) async {
    final String email = payload["email"];
    final String password = payload["password"];
    final String fullname = payload["fullname"];

    state = const AsyncLoading();

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await value.user?.updateDisplayName(fullname);
        state = AsyncData(value.user);
      });
    } on FirebaseAuthException catch (e) {
      state = AsyncError("${e.message}", e.stackTrace ?? StackTrace.current);
    }
  }
}

class ResendLinkNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() => null;

  void sendResetLink(String email) async {
    state = const AsyncLoading();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      state = const AsyncData(null);
    } on FirebaseAuthException catch (e) {
      state = AsyncError("${e.message}", e.stackTrace ?? StackTrace.current);
    }
  }
}
