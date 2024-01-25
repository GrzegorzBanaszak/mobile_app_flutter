import 'dart:ui';

class MyColors {
  static final blackColor = HexColor('#0E0E0E');
  static final whiteColor = HexColor('#FFFFFF');
  static final purpleColor = HexColor('#471AA0');
  static final pinkColor = HexColor('#9747FF');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    // ignore: parameter_assignments
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      // ignore: parameter_assignments
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  // ignore: avoid_final_parameters
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
