import 'package:echo_tech/controllers/auth.controllers.dart';
import 'package:flutter/material.dart';

import '../components/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = "";
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      String username =
          await AuthController().getSessionUserSharedPreferences("username");
      setState(() {
        _username = username;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Loading();
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_username),
              BackButton(
                onPressed: () {
                  const Loading().showAlertDialog(context);
                  AuthController().signOut(context);
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}
