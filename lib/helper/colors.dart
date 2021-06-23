import 'package:flutter/material.dart';

class Colores {

  static Color sobreBackground = _hexToColor("#0b141a");
  static Color background = _hexToColor("#08121d");
  static Color paneBackground = _hexToColor("#0e1a22");
  static Color toastBackground = _hexToColor("#17172e");
  static Color toollbar = _hexToColor("#0e1a22");
  static Color icone = _hexToColor("#959d9f");
  static Color texto = _hexToColor("#a5afb6");
  static Color buttonToolbar = _hexToColor("#959d9f");
  static Color accentColor = _hexToColor("#14b7a2");
  static Color accentColorDark = _hexToColor("#046e60");

  static Color _hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  // static Color findBy(String cor) { _hexToColor(cor); }
}