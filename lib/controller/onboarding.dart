import 'package:flutter/material.dart';

class OnboardingController {
  late PageController indicator;
  late int page;

  // Constructor untuk inisialisasi
  OnboardingController() {
    indicator = PageController();
    page = 0;
  }
}
