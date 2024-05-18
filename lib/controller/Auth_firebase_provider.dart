import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthFirebaseProvider extends ChangeNotifier {
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var loginState = StateLogin.initial;
  var registerState = StateRegister.initial;
  var username = '';
  var uid = '';
  var messageError = '';
  bool obscurePassword = true;

  void processRegister(BuildContext context) async {
    if (formKeyRegister.currentState!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        User dataUser = result.user!;
        username = emailController.text;
        uid = dataUser.uid;
        registerState = StateRegister.success;
      } on FirebaseAuthException catch (error) {
        registerState = StateRegister.error;
        messageError = error.message!;
      } catch (e) {
        loginState = StateLogin.error;
        messageError = e.toString();
      }
    } else {
      showAlertError(context);
    }

    notifyListeners();
  }

  void processLogin(BuildContext context) async {
    if (formKeyLogin.currentState!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        User dataUser = result.user!;
        username = emailController.text;
        uid = dataUser.uid;
        loginState = StateLogin.success;
      } on FirebaseAuthException catch (error) {
        loginState = StateLogin.error;
        messageError = error.message!;
      } catch (e) {
        loginState = StateLogin.error;
        messageError = e.toString();
      }
    } else {
      showAlertError(context);
    }

    notifyListeners();
  }

  void actionObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}

enum StateLogin { initial, success, error }

enum StateRegister { initial, success, error }

showAlertError(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Periksa kelengkapan datamu!'),
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
