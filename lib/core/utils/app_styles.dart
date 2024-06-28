import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppStyles {
  static TextStyle styleMedium16(context){
    return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context,fontSize: 16),
    fontWeight: FontWeight.w500,
  );
  }



static TextStyle styleSemiBold16(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontWeight: FontWeight.w600,
  );
}

static TextStyle styleSemiBold48(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 48),
    fontWeight: FontWeight.w600,
  );
}

static TextStyle styleMedium14(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 14),
    fontWeight: FontWeight.w500,
  );
}

static TextStyle styleMedium18(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 18),
    fontWeight: FontWeight.w500,
  );
}

static TextStyle styleSemiBold26(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 26),
    fontWeight: FontWeight.w600,
  );
}

static TextStyle styleSemiBold14(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 14),
    fontWeight: FontWeight.w600,
  );
}

static TextStyle styleSemiBold18(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 18),
    fontWeight: FontWeight.w600,
  );
}

static TextStyle styleRegular20(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 20),
    fontWeight: FontWeight.w400,
  );
}

static TextStyle styleSemiBold24(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 24),
    fontWeight: FontWeight.w600,
  );
}

static TextStyle styleBold16(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontWeight: FontWeight.bold,
  );
}

static TextStyle styleSemiBold12(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 12),
    fontWeight: FontWeight.w600,
  );
}

static TextStyle styleSemiBold20(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 20),
    fontWeight: FontWeight.w600,
  );
}

static TextStyle styleBold24(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 24),
    fontWeight: FontWeight.bold,
  );
}

static TextStyle styleMedium13(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 13),
    fontWeight: FontWeight.w500,
  );
}

static TextStyle styleBold20(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 20),
    fontWeight: FontWeight.bold,
  );
}

static TextStyle styleSemiBold28(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 28),
    fontWeight: FontWeight.w600,
  );
}

static TextStyle styleRegular16(context) {
  return GoogleFonts.poppins(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontWeight: FontWeight.w400,
  );
}

}

// sacleFactor
// responsive font size
// (min , max) fontsize
double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  // var dispatcher = PlatformDispatcher.instance;
  // var physicalWidth = dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  // double width = physicalWidth / devicePixelRatio;

  double width = MediaQuery.sizeOf(context).width;
  if (width < 600) 
    return width / 400;
  return width / 600;
  
}

