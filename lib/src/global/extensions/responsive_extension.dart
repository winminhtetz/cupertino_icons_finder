extension ScreenSizeResponsive on double {
  bool get isMobile => this <= 375 ? true : false;
}
