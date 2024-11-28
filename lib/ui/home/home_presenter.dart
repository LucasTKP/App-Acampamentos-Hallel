import 'dart:developer';

import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/show_message.dart';
import 'package:app_acampamentos_hallel/ui/home/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePresenter extends StatefulWidget {
  const HomePresenter({super.key});

  @override
  State<HomePresenter> createState() => _HomePresenterState();
}

class _HomePresenterState extends State<HomePresenter> {
  late UserRepository userRepository;
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    userRepository = Dependencies.instance.get<UserRepositoryImpl>();
    userRepository.getUsers().then((value) {
      log('value: $value');
    });
    controller = HomeControllerImpl();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            // if (controller.state == AsyncState.loading) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            return ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text('Sair'));
          },
        ),
      ),
    );
  }

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
