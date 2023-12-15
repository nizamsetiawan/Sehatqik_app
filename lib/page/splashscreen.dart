import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sehatqik_app/main.dart';
import 'package:sehatqik_app/page/onboarding.dart';

class SplashscreenView extends StatelessWidget {
  const SplashscreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OnboardingView()), // Navigate to your desired screen after splash screen
      );
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/Logo.png",
              width: 400,
              height: 400,
            ),
            SpinKitFoldingCube(
              color: Colors.green, // Ganti warna sesuai kebutuhan
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
