import 'package:app_acampamentos_hallel/core/libs/firebase_service.dart';
import 'package:app_acampamentos_hallel/main.dart';
import 'package:flutter/material.dart';

class HomePresenter extends StatefulWidget {
  const HomePresenter({super.key});

  @override
  State<HomePresenter> createState() => _HomePresenterState();
}

class _HomePresenterState extends State<HomePresenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            auth.signOut();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainApp()),
              (Route<dynamic> route) => false,
            );
          },
          child: const Text('sair'),
        ),
      ),
    );
  }
}
