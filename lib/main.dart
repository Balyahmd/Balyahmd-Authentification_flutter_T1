import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tugas_app/controller/register_controller.dart';
import 'package:flutter_tugas_app/view/register_page.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() {
  initFirebase();
}

Future initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegisterController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegisterPage(),
      ),
    );
  }
}
