import 'package:flutter/material.dart';
import 'package:flutter_tugas_app/controller/Auth_firebase_provider.dart';
import 'package:flutter_tugas_app/main.dart';
import 'package:flutter_tugas_app/view/register_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<LoginPage> {
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
          'Login',
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
            key: authProvider.formKeyLogin,
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
                    if (authProvider.formKeyLogin.currentState!.validate()) {
                      authProvider.processLogin(context);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Login  Successful'),
                            content: Text(
                                'Berhasil Login sebagai ${authProvider.emailController.text}, dengan UID ${authProvider.uid}'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
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
                          "login",
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
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account?  ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey, // Ubah warna teks menjadi putih
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register now!',
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
