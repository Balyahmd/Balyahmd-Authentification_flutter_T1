import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  String _username = '';
  String get username => _username;

  String _messageError = '';
  String get messageError => _messageError;
  var loginState = StateLogin.initial;

  void processLogin(String userName, String password) async {
    loginState = StateLogin.loading;
    notifyListeners();
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: password);
      User user = userCredential.user!;
      loginState = StateLogin.success;

      _messageError = 'Hello ${user.uid}';
      print(_messageError);
    } on FirebaseAuthException catch (error) {
      loginState = StateLogin.error;
      _messageError = error.message!;
    } catch (e) {
      loginState = StateLogin.error;
      _messageError = e.toString();
    }
    notifyListeners();
  }

  void toggleMode() {}
}

enum StateLogin { initial, loading, success, error }

showAlertErrorLogin(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Gagal Login!'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'))
        ],
      );
    },
  );
}
