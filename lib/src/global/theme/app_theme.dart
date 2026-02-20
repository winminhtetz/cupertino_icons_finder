import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// AppColors – custom ThemeExtension carrying all design-system colours.
// ---------------------------------------------------------------------------

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.appCanvas,
    required this.shellSurface,
    required this.toolbarSurface,
    required this.dividerColor,
    required this.tileColor,
    required this.textPrimary,
    required this.textMuted,
    required this.accentColor,
    required this.selectedSurface,
    required this.cardGradientStart,
    required this.cardGradientEnd,
    required this.backgroundGradientTop,
    required this.backgroundGradientBottom,
    required this.iconTileColor,
    required this.avatarBg,
    required this.avatarFg,
    required this.profileActionBg,
  });

  final Color appCanvas;
  final Color shellSurface;
  final Color toolbarSurface;
  final Color dividerColor;
  final Color tileColor;
  final Color textPrimary;
  final Color textMuted;
  final Color accentColor;
  final Color selectedSurface;
  final Color cardGradientStart;
  final Color cardGradientEnd;
  final Color backgroundGradientTop;
  final Color backgroundGradientBottom;
  final Color iconTileColor;
  final Color avatarBg;
  final Color avatarFg;
  final Color profileActionBg;

  // ---- Light palette -------------------------------------------------------
  static const light = AppColors(
    appCanvas: Color(0xFFE8EEF4),
    shellSurface: Color(0xFFF8FBFF),
    toolbarSurface: Color(0xFFF2F7FD),
    dividerColor: Color(0xFFD7E0EA),
    tileColor: Color(0xFFEEF4FB),
    textPrimary: Color(0xFF1F2B37),
    textMuted: Color(0xFF6D7C8D),
    accentColor: Color(0xFF2A8BF2),
    selectedSurface: Color(0xFFE9F2FF),
    cardGradientStart: Color(0xFFF1F8FF),
    cardGradientEnd: Color(0xFFEFFBF8),
    backgroundGradientTop: Color(0xFFF2F7FC),
    backgroundGradientBottom: Color(0xFFE1E9F2),
    iconTileColor: Color(0xFF4E6EA8),
    avatarBg: Color(0xFFD9EBFF),
    avatarFg: Color(0xFF0F4D84),
    profileActionBg: Color(0xFFFFFFFF),
  );

  // ---- Dark palette --------------------------------------------------------
  static const dark = AppColors(
    appCanvas: Color(0xFF0D1117),
    shellSurface: Color(0xFF161B22),
    toolbarSurface: Color(0xFF1C2128),
    dividerColor: Color(0xFF30363D),
    tileColor: Color(0xFF21262D),
    textPrimary: Color(0xFFE6EDF3),
    textMuted: Color(0xFF7D8590),
    accentColor: Color(0xFF58A6FF),
    selectedSurface: Color(0xFF1C3557),
    cardGradientStart: Color(0xFF1A2332),
    cardGradientEnd: Color(0xFF182230),
    backgroundGradientTop: Color(0xFF161B22),
    backgroundGradientBottom: Color(0xFF0D1117),
    iconTileColor: Color(0xFF79A6DC),
    avatarBg: Color(0xFF1C3557),
    avatarFg: Color(0xFF79A6DC),
    profileActionBg: Color(0xFF21262D),
  );

  @override
  AppColors copyWith({
    Color? appCanvas,
    Color? shellSurface,
    Color? toolbarSurface,
    Color? dividerColor,
    Color? tileColor,
    Color? textPrimary,
    Color? textMuted,
    Color? accentColor,
    Color? selectedSurface,
    Color? cardGradientStart,
    Color? cardGradientEnd,
    Color? backgroundGradientTop,
    Color? backgroundGradientBottom,
    Color? iconTileColor,
    Color? avatarBg,
    Color? avatarFg,
    Color? profileActionBg,
  }) {
    return AppColors(
      appCanvas: appCanvas ?? this.appCanvas,
      shellSurface: shellSurface ?? this.shellSurface,
      toolbarSurface: toolbarSurface ?? this.toolbarSurface,
      dividerColor: dividerColor ?? this.dividerColor,
      tileColor: tileColor ?? this.tileColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      accentColor: accentColor ?? this.accentColor,
      selectedSurface: selectedSurface ?? this.selectedSurface,
      cardGradientStart: cardGradientStart ?? this.cardGradientStart,
      cardGradientEnd: cardGradientEnd ?? this.cardGradientEnd,
      backgroundGradientTop:
          backgroundGradientTop ?? this.backgroundGradientTop,
      backgroundGradientBottom:
          backgroundGradientBottom ?? this.backgroundGradientBottom,
      iconTileColor: iconTileColor ?? this.iconTileColor,
      avatarBg: avatarBg ?? this.avatarBg,
      avatarFg: avatarFg ?? this.avatarFg,
      profileActionBg: profileActionBg ?? this.profileActionBg,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      appCanvas: Color.lerp(appCanvas, other.appCanvas, t)!,
      shellSurface: Color.lerp(shellSurface, other.shellSurface, t)!,
      toolbarSurface: Color.lerp(toolbarSurface, other.toolbarSurface, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      tileColor: Color.lerp(tileColor, other.tileColor, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      selectedSurface: Color.lerp(selectedSurface, other.selectedSurface, t)!,
      cardGradientStart:
          Color.lerp(cardGradientStart, other.cardGradientStart, t)!,
      cardGradientEnd: Color.lerp(cardGradientEnd, other.cardGradientEnd, t)!,
      backgroundGradientTop:
          Color.lerp(backgroundGradientTop, other.backgroundGradientTop, t)!,
      backgroundGradientBottom: Color.lerp(
          backgroundGradientBottom, other.backgroundGradientBottom, t)!,
      iconTileColor: Color.lerp(iconTileColor, other.iconTileColor, t)!,
      avatarBg: Color.lerp(avatarBg, other.avatarBg, t)!,
      avatarFg: Color.lerp(avatarFg, other.avatarFg, t)!,
      profileActionBg: Color.lerp(profileActionBg, other.profileActionBg, t)!,
    );
  }
}

// ---------------------------------------------------------------------------
// Convenience extension so widgets can write: context.appColors
// ---------------------------------------------------------------------------
extension AppColorsX on BuildContext {
  AppColors get appColors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light;
}

// ---------------------------------------------------------------------------
// AppTheme – builds light and dark ThemeData with AppColors baked in.
// ---------------------------------------------------------------------------
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        fontFamily: 'Gelion',
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2A8BF2),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.light.appCanvas,
        dividerColor: AppColors.light.dividerColor,
        extensions: const [AppColors.light],
      );

  static ThemeData get dark => ThemeData(
        fontFamily: 'Gelion',
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF58A6FF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: AppColors.dark.appCanvas,
        dividerColor: AppColors.dark.dividerColor,
        extensions: const [AppColors.dark],
      );
}
