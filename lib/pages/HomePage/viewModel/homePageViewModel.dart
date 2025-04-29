import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:routi_n/enumsAndConstants/enums.dart';

class Homepageviewmodel extends ChangeNotifier {
  final firebaseInstance = FirebaseAuth.instance;

  final viewState = HomePageState();

  Future<void> logout() async {
    viewState.pageState = PageState.loading;
    notifyListeners();
    try {
      firebaseInstance.signOut();
    } catch (e) {
      viewState.message = e.toString();
      viewState.pageState = PageState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> futureFunctionForTesting() async {
    await Future.delayed(Duration(milliseconds: 100));
    viewState.pageState = PageState.loading;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 3));
      viewState.pageState = PageState.success;
    } catch (e) {
      viewState.message = e.toString();
      viewState.pageState = PageState.error;
    } finally {
      notifyListeners();
    }
  }
}

class HomePageState {
  HomePageState({this.pageState = PageState.success, this.message});

  String? message;
  PageState pageState;
}
