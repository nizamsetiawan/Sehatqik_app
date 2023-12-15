import 'package:flutter/material.dart';
import 'package:sehatqik_app/controller/onboarding.dart';
import 'package:sehatqik_app/page/login.dart';
import 'package:sehatqik_app/page/modul_pasien/signup.dart';
import 'package:sehatqik_app/widgets/onboarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late OnboardingController controller;

  @override
  void initState() {
    super.initState();
    controller = OnboardingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.indicator,
            onPageChanged: (value) {
              setState(() {
                controller.page = value;
              });
              print(controller.page);
            },
            children: [
              OnBoardingWidgets(
                image: "onboarding1.png",
                title: "Selamat Datang di SehatQik",
                subtitle:
                    "Daftarkan diri untuk konsultasi dan\nperoleh obat dengan lebih mudah",
              ),
              OnBoardingWidgets(
                image: "onboarding2.png",
                title: "Pendaftaran Berobat Online",
                subtitle:
                    "Atur jadwal berobat dan pilih dokter\nfavorit Anda dengan cepat",
              ),
              OnBoardingWidgets(
                image: "onboarding3.png",
                title: "Pemesanan Obat dengan Mudah",
                subtitle:
                    "Dapatkan obat yang Anda butuhkan dan\nnikmati pengiriman langsung ke rumah",
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.60),
            padding: const EdgeInsets.only(top: 600),
            child: Column(
              children: [
                if (controller.page != 3)
                  SmoothPageIndicator(
                    controller: controller.indicator,
                    count: 3,
                    effect: const SlideEffect(
                      activeDotColor: Colors.green,
                      spacing: 8.0,
                      radius: 4.0,
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: Colors.grey,
                    ),
                  ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignUpPage()), // Navigate to your desired screen after splash screen
                          );
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Daftar Sekarang",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage()), // Navigate to your desired screen after splash screen
                        );
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Masuk",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
