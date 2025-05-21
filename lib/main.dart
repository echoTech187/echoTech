import 'package:echo_tech/features/home.dart';
import 'package:flutter/material.dart';
import 'components/loading.dart';
import 'controllers/auth.controllers.dart';
import 'features/auth/signin.layout.dart';
import 'features/auth/signup.layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token = "";
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      token = await AuthController().getSessionUserSharedPreferences("token");
      setState(() {
        token = token;
        isLoading = false;
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echo Tech',
      themeAnimationStyle: AnimationStyle(
        duration: const Duration(
          seconds: 1,
        ),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      routes: {
        "/signin":(context)=> const SigninLayout() ,
        "/signup":(context)=> const SignupLayout()
      },
      initialRoute: '/',
      home: (isLoading)
          ? const Center(
              child: Loading(),
            )
          : token.toString().isNotEmpty
              ? const HomePage()
              : const SigninLayout(),
    );
  }
}
