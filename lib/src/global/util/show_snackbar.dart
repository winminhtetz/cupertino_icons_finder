import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

OverlayEntry? _activeToastEntry;
Timer? _toastHideTimer;
Timer? _toastRemoveTimer;
ValueNotifier<bool>? _toastVisibility;

void _removeActiveToast() {
  _toastHideTimer?.cancel();
  _toastRemoveTimer?.cancel();
  _toastHideTimer = null;
  _toastRemoveTimer = null;

  _activeToastEntry?.remove();
  _activeToastEntry = null;

  _toastVisibility?.dispose();
  _toastVisibility = null;
}

extension ShowSnackBar on BuildContext {
  void showSnackBar(String message) {
    final overlay = Overlay.maybeOf(this, rootOverlay: true);
    if (overlay == null) return;

    _removeActiveToast();

    final visibility = ValueNotifier<bool>(false);
    _toastVisibility = visibility;

    final entry = OverlayEntry(
      builder: (context) {
        final topPadding = MediaQuery.of(context).padding.top;

        return IgnorePointer(
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: topPadding > 0 ? 10 : 18),
                child: ValueListenableBuilder<bool>(
                  valueListenable: visibility,
                  child: _ToastCard(message: message),
                  builder: (_, isVisible, child) {
                    return AnimatedSlide(
                      offset: isVisible ? Offset.zero : const Offset(0, -0.35),
                      duration: const Duration(milliseconds: 230),
                      curve: Curves.easeOutCubic,
                      child: AnimatedOpacity(
                        opacity: isVisible ? 1 : 0,
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        child: child,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    _activeToastEntry = entry;
    overlay.insert(entry);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_toastVisibility == visibility) {
        visibility.value = true;
      }
    });

    _toastHideTimer = Timer(const Duration(milliseconds: 1700), () {
      if (_toastVisibility == visibility) {
        visibility.value = false;
      }
    });

    _toastRemoveTimer = Timer(const Duration(milliseconds: 2150), () {
      if (_activeToastEntry == entry) {
        _removeActiveToast();
      }
    });
  }
}

class _ToastCard extends StatelessWidget {
  const _ToastCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 520),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.fromLTRB(10, 10, 14, 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1B6FCC), Color(0xFF15A6A1)],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF225787).withValues(alpha: 0.35),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
