import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_app/controller/Auth_firebase_provider.dart';
import 'package:flutter_tugas_app/main.dart';
import 'package:flutter_tugas_app/view/login_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthFirebaseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.home, color: Colors.white),
        ),
        title: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _refreshApp(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Form(
            key: authProvider.formKeyRegister,
            child: ListView(
              children: [
                SizedBox(
                    child: SvgPicture.asset(
                  "lib/assets/images/logo_page.svg",
                  width: 220,
                  height: 220,
                )),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Welcome To My Apps, Are you Testing ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                    controller: authProvider.emailController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Tolong isi Email dengan benar';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Input Your Email',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: authProvider.passwordController,
                    obscureText: authProvider.obscurePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tolong isi Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Input Your Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              authProvider.actionObscurePassword();
                            },
                            icon: Icon(authProvider.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  onPressed: () {
                    if (authProvider.formKeyRegister.currentState!.validate()) {
                      authProvider.processRegister(context);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Register Successful'),
                            content: Text(
                                'Berhasil Regsiter sebagai ${authProvider.emailController.text}, dengan UID ${authProvider.uid}'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child: Text('Ok'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showAlertError();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Pusatkan elemen di tengah baris
                    children: [
                      Expanded(
                        child: Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account?  ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey, // Ubah warna teks menjadi putih
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Log in now!',
                          style: TextStyle(
                            color: Colors
                                .deepPurpleAccent, // Ubah warna teks "Log in now!" menjadi ungu
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertError() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Periksa kelengkapan datamu!'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'))
          ],
        );
      },
    );
  }

  void _refreshApp(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }
}
