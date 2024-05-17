import 'package:flutter/material.dart';
import 'package:flutter_tugas_app/controller/register_controller.dart';
import 'package:flutter_tugas_app/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? username;
  String? password;

  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.sizeOf(context).width;

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
            key: _formKey,
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
                    controller: usernameController,
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
                    controller: passwordController,
                    obscureText: obscurePassword,
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
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            icon: Icon(obscurePassword == true
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                const SizedBox(
                  height: 10,
                ),
                context.watch<RegisterController>().regisState !=
                        StateRegis.success
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.deepPurpleAccent),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Register Successful'),
                                  content: Text(
                                      'Berhasil Regis sebagai ${usernameController.text}, dengan UID:'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
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
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
                context.watch<RegisterController>().regisState ==
                        StateRegis.error
                    ? Text(
                        context.watch<RegisterController>().messageError,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            elevation: 5),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<RegisterController>().processLogin(
                                usernameController.text,
                                passwordController.text);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Login Successful'),
                                  content: Text(
                                      'Berhasil Login sebagai ${usernameController.text}, , dengan UID:'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
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
                                "Login",
                                textAlign: TextAlign
                                    .center, // Pusatkan teks ke dalam Expanded
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 50,
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
