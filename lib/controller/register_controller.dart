import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  String _username = '';
  String get username => _username;

  String _messageError = '';
  String get messageError => _messageError;
  var regisState = StateRegis.initial;

  void processRegister(String userName, String password) async {
    regisState = StateRegis.loading;
    notifyListeners();
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userName, password: password);
      User user = userCredential.user!;
      regisState = StateRegis.success;
      _messageError = 'Hello ${user.uid}';
    } on FirebaseAuthException catch (error) {
      regisState = StateRegis.error;
      _messageError = error.message!;
    } catch (e) {
      regisState = StateRegis.error;
      _messageError = e.toString();
    }
    notifyListeners();
  }

  void processLogin(String userName, String password) async {
    regisState = StateRegis.loading;
    notifyListeners();
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: password);
      User user = userCredential.user!;
      regisState = StateRegis.success;

      _messageError = 'Hello ${user.uid}';
      print(_messageError);
    } on FirebaseAuthException catch (error) {
      regisState = StateRegis.error;
      _messageError = error.message!;
    } catch (e) {
      regisState = StateRegis.error;
      _messageError = e.toString();
    }
    notifyListeners();
  }

  void toggleMode() {}
}

enum StateRegis { initial, loading, success, error }

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
