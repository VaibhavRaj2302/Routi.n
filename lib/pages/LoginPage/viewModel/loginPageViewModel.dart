import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:routi_n/enumsAndConstants/enums.dart';

class Loginpageviewmodel extends ChangeNotifier {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  final viewState = LoginPageState();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    viewState.message = null;
    viewState.pageState = PageState.loading;
    notifyListeners();
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      viewState.pageState = PageState.success;
      return userCredential.user;
    } catch (e) {
      viewState.message = e.toString();
      viewState.pageState = PageState.error;
      return null;
    } finally {
      notifyListeners();
    }
  }

  Future<User?> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    viewState.message = null;
    viewState.pageState = PageState.loading;
    notifyListeners();
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      viewState.pageState = PageState.success;
      return userCredential.user;
    } catch (e) {
      viewState.message = e.toString();
      viewState.pageState = PageState.error;
      return null;
    } finally {
      notifyListeners();
    }
  }
}

class LoginPageState {
  LoginPageState({this.pageState = PageState.success, this.message});

  String? message;
  PageState pageState;
}
