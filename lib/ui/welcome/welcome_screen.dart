import 'package:acamps_canaa/ui/login/login_presenter.dart';
import 'package:acamps_canaa/ui/register/register_user_presenter.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/welcome.png'), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A caminho\nda Terra\nPrometida',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '~ Falta pouco!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPresenter())),
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                          backgroundColor: WidgetStateProperty.all(Colors.white.withOpacity(0.3)),
                          overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.4)),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.4)),
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterUserPresenter())),
                          child: const Text(
                            'Criar uma conta',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(child: Image.asset('assets/logos/canaa/canaa_white.png', width: 80, height: 80)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
