//* this is a class to access the same theme through the whole program

import 'package:flutter/material.dart';

class Colors {
  const Colors();

  static const Color loginGradientStart = const Color(0xFF7B98FF);
  static const Color loginGradientEnd = const Color(0xFF436BFC);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
