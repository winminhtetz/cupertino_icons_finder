import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ios_icon_finder/services/favorite_icons/models/fav_icon_model.dart';
import 'package:ios_icon_finder/services/favorite_icons/services/fav_icon_service.dart';
import 'package:ios_icon_finder/src/global/util/show_snackbar.dart';

const Color _pageBackground = Color(0xFFE8EEF4);
const Color _pageSurface = Color(0xFFF8FBFF);
const Color _cardColor = Color(0xFFEEF4FB);
const Color _textPrimary = Color(0xFF1F2B37);
const Color _textMuted = Color(0xFF6D7C8D);
const Color _accentColor = Color(0xFF2A8BF2);
const Color _dividerColor = Color(0xFFD7E0EA);

class FavIconsPage extends ConsumerWidget {
  const FavIconsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favIcons = ref.watch(favIconsServiceProvider);

    return Scaffold(
      backgroundColor: _pageBackground,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF2F7FC), Color(0xFFE1E9F2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _FavoritesHeader(
                count: favIcons.length,
                onBack: () => Navigator.pop(context),
                onClearAll: favIcons.isEmpty
                    ? null
                    : () => _onClearAll(context: context, ref: ref),
              ),
              Expanded(
                child: Container(
                  color: _pageSurface,
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                  child: favIcons.isEmpty
                      ? const _EmptyFavoritesState()
                      : _FavoritesGrid(
                          favorites: favIcons,
                          onCopy: (iconName) => _onCopy(
                            context: context,
                            iconName: iconName,
                          ),
                          onRemove: (iconName) => _onRemove(
                            context: context,
                            ref: ref,
                            iconName: iconName,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onCopy({
    required BuildContext context,
    required String iconName,
  }) async {
    await Clipboard.setData(ClipboardData(text: iconName));
    if (!context.mounted) return;
    context.showSnackBar('Copied $iconName');
  }

  void _onRemove({
    required BuildContext context,
    required WidgetRef ref,
    required String iconName,
  }) {
    ref.read(favIconsServiceProvider.notifier).deleteFavorite(iconName);
    context.showSnackBar('Removed $iconName');
  }

  Future<void> _onClearAll({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final shouldClear = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear all favorites?'),
          content:
              const Text('This will remove all saved icons from this device.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              style: FilledButton.styleFrom(backgroundColor: _accentColor),
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );

    if (shouldClear != true) return;
    ref.read(favIconsServiceProvider.notifier).deleteAll();
    if (!context.mounted) return;
    context.showSnackBar('Favorites cleared');
  }
}

class _FavoritesHeader extends StatelessWidget {
  const _FavoritesHeader({
    required this.count,
    required this.onBack,
    required this.onClearAll,
  });

  final int count;
  final VoidCallback onBack;
  final VoidCallback? onClearAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F7FD),
      padding: const EdgeInsets.fromLTRB(10, 8, 12, 10),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(CupertinoIcons.back, color: _textPrimary),
          ),
          const SizedBox(width: 2),
          const Expanded(
            child: Text(
              'Favorite Icons',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _dividerColor),
            ),
            child: Text(
              '$count saved',
              style: const TextStyle(
                color: _textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: onClearAll,
            tooltip: 'Clear all',
            icon: Icon(
              CupertinoIcons.trash,
              color: onClearAll == null ? _textMuted : _textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoritesGrid extends StatelessWidget {
  const _FavoritesGrid({
    required this.favorites,
    required this.onCopy,
    required this.onRemove,
  });

  final List<FavIcon> favorites;
  final ValueChanged<String> onCopy;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width < 500
            ? 2
            : width < 880
                ? 3
                : math.max(4, (width / 210).floor());

        return GridView.builder(
          itemCount: favorites.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: 1.02,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final favorite = favorites[index];
            return _FavoriteTile(
              favorite: favorite,
              onCopy: () => onCopy(favorite.iconName),
              onRemove: () => onRemove(favorite.iconName),
            );
          },
        );
      },
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  const _FavoriteTile({
    required this.favorite,
    required this.onCopy,
    required this.onRemove,
  });

  final FavIcon favorite;
  final VoidCallback onCopy;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final iconData = IconData(
      favorite.iconCode,
      fontFamily: 'CupertinoIcons',
      fontPackage: CupertinoIcons.iconFontPackage,
    );
    final hexCode = favorite.iconCode.toRadixString(16).padLeft(4, '0');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onDoubleTap: onCopy,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFDCE5EF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.heart_fill,
                    size: 14,
                    color: _accentColor,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onRemove,
                    splashRadius: 16,
                    icon: const Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: _textMuted,
                      size: 18,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Icon(
                    iconData,
                    size: 38,
                    color: const Color(0xFF4E6EA8),
                  ),
                ),
              ),
              Text(
                _toReadableName(favorite.iconName),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '0x$hexCode',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyFavoritesState extends StatelessWidget {
  const _EmptyFavoritesState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _dividerColor),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.heart_slash, size: 28, color: _textMuted),
            SizedBox(height: 10),
            Text(
              'No favorite icons yet',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Save icons from the main page and they will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _toReadableName(String value) {
  return value
      .split('_')
      .where((part) => part.isNotEmpty)
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');
}
