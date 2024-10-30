import 'package:flutter/material.dart';

// Fungsi untuk mendapatkan ukuran font responsif
/// fontSize default mobile = 2.5
/// fontSize default tablet = 5.12
double _getFontSize(MediaQueryData mq, double safeAreaHorizontal, double safeAreaVertical) {
  return mq.size.width > 600.0 ? (mq.size.width / 2.5 - safeAreaHorizontal) / 100 : (mq.size.width / 1.5 - safeAreaHorizontal) / 100;
}

class SizeConfig {
  // MediaQuery data untuk mendapatkan informasi layar dan padding aman
  static MediaQueryData mediaQuery = const MediaQueryData();

  // Dimensi layar
  static double screenWidth = 0;
  static double screenHeight = 0;

  // Deteksi perangkat
  static bool isMobile = true;
  static bool isTablet = false;

  // Ukuran padding dan margin default
  static double get kDefaultPadding => isMobile ? 8 : 16;

  static double get kDefaultMargin => isMobile ? 8 : 16;

  // Tinggi AppBar yang disesuaikan dengan tipe perangkat
  static double get appBarHeight => isMobile ? kToolbarHeight : 90;

  // Ukuran umum ikon
  static double get iconGeneralHeightAndWidth => isMobile ? 30 : 40;

  // Menentukan ukuran horizontal dan vertical aman, dengan padding kiri-kanan dan atas-bawah
  static double get safeBlockHorizontal => (screenWidth - _safeAreaHorizontal) / 100;

  static double get safeBlockVertical => (screenHeight - _safeAreaVertical) / 100;

  // Ukuran font dasar, responsif sesuai perangkat
  static double get baseFontSize => _getFontSize(mediaQuery, _safeAreaHorizontal, _safeAreaVertical);

  // Mengambil padding aman dari MediaQuery
  static double get _safeAreaHorizontal => mediaQuery.padding.left + mediaQuery.padding.right;

  static double get _safeAreaVertical => mediaQuery.padding.top + mediaQuery.padding.bottom;

  // Border radius responsif
  static double get kDefaultBorderRadius => isMobile ? 8 : 12;

  // Inisialisasi pada startup aplikasi
  static void initOnStartUp(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;

    // Logika untuk menentukan apakah perangkat adalah ponsel atau tablet
    isMobile = screenWidth < 600;
    isTablet = !isMobile && screenWidth >= 600 && screenWidth < 1200;
  }
}
