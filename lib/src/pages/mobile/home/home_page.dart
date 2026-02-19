import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ios_icon_finder/services/categories/models/icon_category_model.dart';
import 'package:ios_icon_finder/services/categories/services/icon_category_service.dart';
import 'package:ios_icon_finder/services/favorite_icons/models/fav_icon_model.dart';
import 'package:ios_icon_finder/services/favorite_icons/services/fav_icon_service.dart';
import 'package:ios_icon_finder/services/ios_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/services/ios_icons/services/ios_icon_service.dart';
import 'package:ios_icon_finder/src/global/util/show_snackbar.dart';
import 'package:ios_icon_finder/src/pages/mobile/fav_icons/fav_icons_page.dart';

const Color _appCanvas = Color(0xFFE8EEF4);
const Color _shellSurface = Color(0xFFF8FBFF);
const Color _toolbarSurface = Color(0xFFF2F7FD);
const Color _dividerColor = Color(0xFFD7E0EA);
const Color _tileColor = Color(0xFFEEF4FB);
const Color _textPrimary = Color(0xFF1F2B37);
const Color _textMuted = Color(0xFF6D7C8D);
const Color _accentColor = Color(0xFF2A8BF2);
const Color _selectedSurface = Color(0xFFE9F2FF);

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useState('');
    final selectedCategoryId = useState<int?>(null);
    final selectedIconName = useState<String?>(null);
    final searchController = useTextEditingController();

    useEffect(() {
      void syncQuery() {
        query.value = searchController.text.trim();
      }

      searchController.addListener(syncQuery);
      return () => searchController.removeListener(syncQuery);
    }, [searchController]);

    final iconsAsync = ref.watch(iosIconServiceProvider);
    final categoriesAsync = ref.watch(iconCategoriesProvider);
    final favorites = ref.watch(favIconsServiceProvider);

    final allIcons = iconsAsync.valueOrNull ?? const <IosIcon>[];
    final categories = categoriesAsync.valueOrNull ?? const <IconCategory>[];
    final categoryCounts = _buildCategoryCounts(allIcons);
    final filteredIcons = _filterIcons(
      icons: allIcons,
      query: query.value,
      categoryId: selectedCategoryId.value,
    );

    return Scaffold(
      backgroundColor: _appCanvas,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF2F7FC), Color(0xFFE1E9F2)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 980;
              final selectedIcon = _resolveSelectedIcon(
                filteredIcons: filteredIcons,
                selectedName: selectedIconName.value,
                fallbackToFirst: !compact,
              );

              bool isFavorite(IosIcon icon) {
                return favorites.any(
                  (favorite) =>
                      favorite.iconName == icon.iconName &&
                      favorite.iconCode == icon.codePoint,
                );
              }

              void toggleFavorite(IosIcon icon) {
                final notifier = ref.read(favIconsServiceProvider.notifier);
                if (isFavorite(icon)) {
                  notifier.deleteFavorite(icon.iconName);
                  _showToast(
                      context, 'Removed ${icon.iconName} from favorites');
                  return;
                }
                notifier.addToFavorite(
                  FavIcon(
                    iconName: icon.iconName,
                    iconCode: icon.codePoint,
                  ),
                );
                _showToast(context, 'Added ${icon.iconName} to favorites');
              }

              return Container(
                color: _shellSurface,
                child: Column(
                  children: [
                    _TopToolbar(
                      compact: compact,
                      controller: searchController,
                      hasQuery: query.value.isNotEmpty,
                      favoritesCount: favorites.length,
                      onClearQuery: () => searchController.clear(),
                      onOpenFavorites: () => _openFavorites(context),
                      onRefreshAll: () {
                        ref.invalidate(iosIconServiceProvider);
                        ref.invalidate(iconCategoriesProvider);
                      },
                    ),
                    Expanded(
                      child: compact
                          ? _CompactLayout(
                              categoriesAsync: categoriesAsync,
                              iconsAsync: iconsAsync,
                              categories: categories,
                              categoryCounts: categoryCounts,
                              filteredIcons: filteredIcons,
                              selectedCategoryId: selectedCategoryId.value,
                              selectedIcon: selectedIcon,
                              onSelectCategory: (value) {
                                selectedCategoryId.value = value;
                                selectedIconName.value = null;
                              },
                              onSelectIcon: (icon) =>
                                  selectedIconName.value = icon.iconName,
                              onToggleFavorite: toggleFavorite,
                              isFavorite: isFavorite,
                              query: query.value,
                            )
                          : _DesktopLayout(
                              categoriesAsync: categoriesAsync,
                              iconsAsync: iconsAsync,
                              categories: categories,
                              categoryCounts: categoryCounts,
                              filteredIcons: filteredIcons,
                              selectedCategoryId: selectedCategoryId.value,
                              selectedIcon: selectedIcon,
                              favoritesCount: favorites.length,
                              onSelectCategory: (value) {
                                selectedCategoryId.value = value;
                                selectedIconName.value = null;
                              },
                              onSelectIcon: (icon) =>
                                  selectedIconName.value = icon.iconName,
                              onToggleFavorite: toggleFavorite,
                              isFavorite: isFavorite,
                              query: query.value,
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _openFavorites(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FavIconsPage()),
    );
  }
}

class _TopToolbar extends StatelessWidget {
  const _TopToolbar({
    required this.compact,
    required this.controller,
    required this.hasQuery,
    required this.favoritesCount,
    required this.onClearQuery,
    required this.onOpenFavorites,
    required this.onRefreshAll,
  });

  final bool compact;
  final TextEditingController controller;
  final bool hasQuery;
  final int favoritesCount;
  final VoidCallback onClearQuery;
  final VoidCallback onOpenFavorites;
  final VoidCallback onRefreshAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _toolbarSurface,
      padding:
          EdgeInsets.fromLTRB(compact ? 14 : 20, 14, compact ? 14 : 20, 14),
      child: compact ? _buildCompact(context) : _buildDesktop(context),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      children: [
        const _BrandHeader(),
        const SizedBox(width: 24),
        Expanded(
          child: _SearchField(
            controller: controller,
            hasQuery: hasQuery,
            onClear: onClearQuery,
          ),
        ),
        const SizedBox(width: 12),
        _ToolbarIconButton(
          icon: CupertinoIcons.heart,
          onPressed: onOpenFavorites,
          badgeText: favoritesCount > 0 ? favoritesCount.toString() : null,
        ),
      ],
    );
  }

  Widget _buildCompact(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const _BrandHeader(compact: true),
            const Spacer(),
            _ToolbarIconButton(
              icon: CupertinoIcons.heart,
              onPressed: onOpenFavorites,
              badgeText: favoritesCount > 0 ? favoritesCount.toString() : null,
            ),
            _ToolbarIconButton(
              icon: CupertinoIcons.refresh,
              onPressed: onRefreshAll,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SearchField(
          controller: controller,
          hasQuery: hasQuery,
          onClear: onClearQuery,
        ),
      ],
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          CupertinoIcons.compass_fill,
          color: _accentColor,
          size: compact ? 18 : 22,
        ),
        SizedBox(width: compact ? 8 : 10),
        Text(
          'Cupertino Icons Finder',
          style: TextStyle(
            color: _textPrimary,
            fontSize: compact ? 18 : 24,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

class _ToolbarIconButton extends StatelessWidget {
  const _ToolbarIconButton({
    required this.icon,
    required this.onPressed,
    this.badgeText,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: onPressed,
            splashRadius: 19,
            icon: Icon(icon, color: _textPrimary, size: 19),
          ),
          if (badgeText != null)
            Positioned(
              right: 2,
              top: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: _accentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeText!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.hasQuery,
    required this.onClear,
  });

  final TextEditingController controller;
  final bool hasQuery;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        hintText: 'Find symbols, names, or category',
        hintStyle: const TextStyle(
          color: _textMuted,
          fontSize: 14,
        ),
        prefixIcon:
            const Icon(CupertinoIcons.search, color: _textMuted, size: 18),
        suffixIcon: hasQuery
            ? IconButton(
                onPressed: onClear,
                icon: const Icon(CupertinoIcons.clear_circled_solid, size: 18),
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.categoriesAsync,
    required this.iconsAsync,
    required this.categories,
    required this.categoryCounts,
    required this.filteredIcons,
    required this.selectedCategoryId,
    required this.selectedIcon,
    required this.favoritesCount,
    required this.onSelectCategory,
    required this.onSelectIcon,
    required this.onToggleFavorite,
    required this.isFavorite,
    required this.query,
  });

  final AsyncValue<List<IconCategory>> categoriesAsync;
  final AsyncValue<List<IosIcon>> iconsAsync;
  final List<IconCategory> categories;
  final Map<int, int> categoryCounts;
  final List<IosIcon> filteredIcons;
  final int? selectedCategoryId;
  final IosIcon? selectedIcon;
  final int favoritesCount;
  final ValueChanged<int?> onSelectCategory;
  final ValueChanged<IosIcon> onSelectIcon;
  final ValueChanged<IosIcon> onToggleFavorite;
  final bool Function(IosIcon icon) isFavorite;
  final String query;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: _CategorySidebar(
            categoriesAsync: categoriesAsync,
            categories: categories,
            categoryCounts: categoryCounts,
            selectedCategoryId: selectedCategoryId,
            favoritesCount: favoritesCount,
            onSelectCategory: onSelectCategory,
          ),
        ),
        const VerticalDivider(width: 1, color: _dividerColor),
        Expanded(
          child: _IconGridPane(
            iconsAsync: iconsAsync,
            filteredIcons: filteredIcons,
            query: query,
            selectedIcon: selectedIcon,
            onSelectIcon: onSelectIcon,
            onToggleFavorite: onToggleFavorite,
            isFavorite: isFavorite,
          ),
        ),
      ],
    );
  }
}

class _CompactLayout extends StatelessWidget {
  const _CompactLayout({
    required this.categoriesAsync,
    required this.iconsAsync,
    required this.categories,
    required this.categoryCounts,
    required this.filteredIcons,
    required this.selectedCategoryId,
    required this.selectedIcon,
    required this.onSelectCategory,
    required this.onSelectIcon,
    required this.onToggleFavorite,
    required this.isFavorite,
    required this.query,
  });

  final AsyncValue<List<IconCategory>> categoriesAsync;
  final AsyncValue<List<IosIcon>> iconsAsync;
  final List<IconCategory> categories;
  final Map<int, int> categoryCounts;
  final List<IosIcon> filteredIcons;
  final int? selectedCategoryId;
  final IosIcon? selectedIcon;
  final ValueChanged<int?> onSelectCategory;
  final ValueChanged<IosIcon> onSelectIcon;
  final ValueChanged<IosIcon> onToggleFavorite;
  final bool Function(IosIcon icon) isFavorite;
  final String query;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CompactCategoryBar(
          categoriesAsync: categoriesAsync,
          categories: categories,
          categoryCounts: categoryCounts,
          selectedCategoryId: selectedCategoryId,
          onSelectCategory: onSelectCategory,
        ),
        Expanded(
          child: _IconGridPane(
            iconsAsync: iconsAsync,
            filteredIcons: filteredIcons,
            query: query,
            selectedIcon: selectedIcon,
            onSelectIcon: onSelectIcon,
            onToggleFavorite: onToggleFavorite,
            isFavorite: isFavorite,
            compact: true,
          ),
        ),
      ],
    );
  }
}

class _CategorySidebar extends StatelessWidget {
  const _CategorySidebar({
    required this.categoriesAsync,
    required this.categories,
    required this.categoryCounts,
    required this.selectedCategoryId,
    required this.favoritesCount,
    required this.onSelectCategory,
  });

  final AsyncValue<List<IconCategory>> categoriesAsync;
  final List<IconCategory> categories;
  final Map<int, int> categoryCounts;
  final int? selectedCategoryId;
  final int favoritesCount;
  final ValueChanged<int?> onSelectCategory;

  @override
  Widget build(BuildContext context) {
    final total =
        categoryCounts.values.fold<int>(0, (sum, count) => sum + count);

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: 'Icon Catalog',
            icon: CupertinoIcons.square_stack_3d_up_fill,
            textSize: 18,
          ),
          const SizedBox(height: 12),
          _CategoryTile(
            name: 'Everything',
            count: total,
            selected: selectedCategoryId == null,
            onTap: () => onSelectCategory(null),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: categoriesAsync.when(
              data: (_) => ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _CategoryTile(
                    name: _toTitle(category.categoryName),
                    count: categoryCounts[category.categoryId] ?? 0,
                    selected: selectedCategoryId == category.categoryId,
                    onTap: () => onSelectCategory(category.categoryId),
                  );
                },
              ),
              loading: () => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2)),
              error: (error, _) => Center(
                child: Text(
                  'Failed to load categories',
                  style: TextStyle(color: Colors.red.shade300),
                ),
              ),
            ),
          ),
          const Divider(height: 24, color: _dividerColor),
          _DeveloperProfileCard(
            favoritesCount: favoritesCount,
          ),
        ],
      ),
    );
  }
}

class _CompactCategoryBar extends StatelessWidget {
  const _CompactCategoryBar({
    required this.categoriesAsync,
    required this.categories,
    required this.categoryCounts,
    required this.selectedCategoryId,
    required this.onSelectCategory,
  });

  final AsyncValue<List<IconCategory>> categoriesAsync;
  final List<IconCategory> categories;
  final Map<int, int> categoryCounts;
  final int? selectedCategoryId;
  final ValueChanged<int?> onSelectCategory;

  @override
  Widget build(BuildContext context) {
    final total =
        categoryCounts.values.fold<int>(0, (sum, count) => sum + count);
    return Container(
      height: 58,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _dividerColor)),
      ),
      child: categoriesAsync.when(
        data: (_) => ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            _CategoryChip(
              label: 'All icons ($total)',
              selected: selectedCategoryId == null,
              onTap: () => onSelectCategory(null),
            ),
            ...categories.map(
              (category) => _CategoryChip(
                label:
                    '${_toTitle(category.categoryName)} (${categoryCounts[category.categoryId] ?? 0})',
                selected: selectedCategoryId == category.categoryId,
                onTap: () => onSelectCategory(category.categoryId),
              ),
            ),
          ],
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        error: (error, _) => Center(
          child: Text(
            'Could not load categories',
            style: TextStyle(color: Colors.red.shade300, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: selected ? _accentColor : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: selected ? _accentColor : _dividerColor),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : _textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.icon,
    this.textSize = 20,
  });

  final String title;
  final IconData icon;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: textSize <= 18 ? 16 : 18, color: _textPrimary),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.w800,
            color: _textPrimary,
          ),
        ),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.name,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: selected
                      ? _accentColor
                      : _textMuted.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$count',
                style: const TextStyle(
                  color: _textMuted,
                  fontSize: 13,
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

class _DeveloperProfileCard extends StatelessWidget {
  const _DeveloperProfileCard({
    required this.favoritesCount,
  });

  final int favoritesCount;

  static const String _name = 'Win Min Htet';
  static const String _role = 'Mobile Developer';
  static const String _github = 'https://github.com/winminhtetz';
  static const String _portfolio = 'https://winminhtetz.pages.dev';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _dividerColor),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF1F8FF), Color(0xFFEFFBF8)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9EBFF),
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  'WM',
                  style: TextStyle(
                    color: Color(0xFF0F4D84),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      _role,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Need custom icon tooling or app support? Reach out fast:',
            style: TextStyle(
              color: _textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),
          _ProfileAction(
            icon: CupertinoIcons.globe,
            label: 'Portfolio',
            value: _portfolio,
            onTap: () => _copyContact(
              context,
              value: _portfolio,
              label: 'Portfolio link',
            ),
          ),
          const SizedBox(height: 8),
          _ProfileAction(
            icon: CupertinoIcons.chevron_left_slash_chevron_right,
            label: 'GitHub',
            value: _github,
            onTap: () => _copyContact(
              context,
              value: _github,
              label: 'GitHub link',
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                CupertinoIcons.heart_fill,
                size: 13,
                color: _accentColor,
              ),
              const SizedBox(width: 6),
              Text(
                'Saved icons: $favoritesCount',
                style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _copyContact(
    BuildContext context, {
    required String value,
    required String label,
  }) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    _showToast(context, '$label copied');
  }
}

class _ProfileAction extends StatelessWidget {
  const _ProfileAction({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dividerColor),
          ),
          child: Row(
            children: [
              Icon(icon, size: 14, color: _accentColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$label: $value',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                CupertinoIcons.doc_on_doc,
                size: 13,
                color: _textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconGridPane extends StatelessWidget {
  const _IconGridPane({
    required this.iconsAsync,
    required this.filteredIcons,
    required this.query,
    required this.selectedIcon,
    required this.onSelectIcon,
    required this.onToggleFavorite,
    required this.isFavorite,
    this.compact = false,
  });

  final AsyncValue<List<IosIcon>> iconsAsync;
  final List<IosIcon> filteredIcons;
  final String query;
  final IosIcon? selectedIcon;
  final ValueChanged<IosIcon> onSelectIcon;
  final ValueChanged<IosIcon> onToggleFavorite;
  final bool Function(IosIcon icon) isFavorite;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (iconsAsync.isLoading && iconsAsync.valueOrNull == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (iconsAsync.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                color: Colors.red.shade300,
                size: 22,
              ),
              const SizedBox(height: 10),
              Text(
                'Unable to load icon data',
                style: TextStyle(
                  color: Colors.red.shade300,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (filteredIcons.isEmpty) {
      final extra = query.isEmpty ? 'for selected category.' : 'for "$query".';
      return Center(
        child: Text(
          'No icons found $extra',
          style: const TextStyle(color: _textMuted, fontSize: 16),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = compact
            ? math.max(2, (width / 148).floor())
            : math.max(3, (width / 168).floor());

        return GridView.builder(
          padding: EdgeInsets.all(compact ? 12 : 18),
          itemCount: filteredIcons.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: 1,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          itemBuilder: (context, index) {
            final icon = filteredIcons[index];
            return _IconGridTile(
              icon: icon,
              selected: selectedIcon?.iconName == icon.iconName,
              favorite: isFavorite(icon),
              onTap: () => onSelectIcon(icon),
              onCopyName: () => _copyIconName(context, icon.iconName),
              onToggleFavorite: () => onToggleFavorite(icon),
            );
          },
        );
      },
    );
  }

  Future<void> _copyIconName(BuildContext context, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    _showToast(context, 'Copied $value');
  }
}

class _IconGridTile extends StatelessWidget {
  const _IconGridTile({
    required this.icon,
    required this.selected,
    required this.favorite,
    required this.onTap,
    required this.onCopyName,
    required this.onToggleFavorite,
  });

  final IosIcon icon;
  final bool selected;
  final bool favorite;
  final VoidCallback onTap;
  final VoidCallback onCopyName;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final iconData = IconData(
      icon.codePoint,
      fontFamily: icon.iconFont,
      fontPackage: icon.iconFontPackage ?? CupertinoIcons.iconFontPackage,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        onDoubleTap: onCopyName,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: selected ? _selectedSurface : _tileColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? _accentColor : const Color(0xFFDCE5EF),
              width: selected ? 1.7 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.95),
                blurRadius: 0,
                offset: const Offset(0, 0),
              ),
              if (selected)
                BoxShadow(
                  color: _accentColor.withValues(alpha: 0.22),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: IconButton(
                    onPressed: onToggleFavorite,
                    splashRadius: 17,
                    icon: Icon(
                      favorite
                          ? CupertinoIcons.bookmark_fill
                          : CupertinoIcons.bookmark,
                      color: favorite ? _accentColor : _textMuted,
                      size: 17,
                    ),
                  ),
                ),
              ),
              Center(
                child: Icon(
                  iconData,
                  size: 36,
                  color: const Color(0xFF4E6EA8),
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                bottom: 10,
                child: Text(
                  _toReadableName(icon.iconName),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _textPrimary,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<IosIcon> _filterIcons({
  required List<IosIcon> icons,
  required String query,
  required int? categoryId,
}) {
  final normalizedQuery = query.toLowerCase();
  return icons.where((icon) {
    final matchesCategory = categoryId == null || icon.categoryId == categoryId;
    final matchesQuery = normalizedQuery.isEmpty ||
        icon.iconName.toLowerCase().contains(normalizedQuery);
    return matchesCategory && matchesQuery;
  }).toList();
}

IosIcon? _resolveSelectedIcon({
  required List<IosIcon> filteredIcons,
  required String? selectedName,
  required bool fallbackToFirst,
}) {
  if (selectedName != null) {
    for (final icon in filteredIcons) {
      if (icon.iconName == selectedName) {
        return icon;
      }
    }
  }
  if (!fallbackToFirst) return null;
  if (filteredIcons.isNotEmpty) return filteredIcons.first;
  return null;
}

Map<int, int> _buildCategoryCounts(List<IosIcon> icons) {
  final map = <int, int>{};
  for (final icon in icons) {
    final categoryId = icon.categoryId;
    if (categoryId == null) continue;
    map[categoryId] = (map[categoryId] ?? 0) + 1;
  }
  return map;
}

String _toReadableName(String value) {
  return value
      .split('_')
      .where((part) => part.isNotEmpty)
      .map(_toTitle)
      .join(' ');
}

String _toTitle(String value) {
  if (value.isEmpty) return value;
  return '${value[0].toUpperCase()}${value.substring(1)}';
}

void _showToast(BuildContext context, String message) {
  context.showSnackBar(message);
}
