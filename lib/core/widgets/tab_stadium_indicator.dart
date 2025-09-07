import 'package:flutter/material.dart';

class StadiumTabIndicator extends Decoration {
  const StadiumTabIndicator({
    this.color = Colors.grey,
    this.verticalPadding = 4,
    this.horizontalFactor = 0.8, // relative to rect.height
    this.horizontalPadding, // fixed; if set, overrides factor
  });

  final Color color;
  final double verticalPadding;

  /// If [horizontalPadding] is null, we use rect.height * [horizontalFactor].
  final double horizontalFactor;
  final double? horizontalPadding;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _StadiumTabPainter(
      color: color,
      verticalPadding: verticalPadding,
      horizontalFactor: horizontalFactor,
      horizontalPadding: horizontalPadding,
      onChange: onChanged,
    );
  }
}

class _StadiumTabPainter extends BoxPainter {
  _StadiumTabPainter({
    required this.color,
    required this.verticalPadding,
    required this.horizontalFactor,
    required this.horizontalPadding,
    VoidCallback? onChange,
  }) : _paint = Paint()
         ..style = PaintingStyle.fill
         ..color = color,
       super(onChange);

  final Color color;
  final double verticalPadding;
  final double horizontalFactor;
  final double? horizontalPadding;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    Rect rect = offset & configuration.size!;

    // Make the pill wider than the label: expand left/right
    final hp = horizontalPadding ?? (rect.height * horizontalFactor);

    // Add breathing room vertically: shrink top/bottom
    rect = Rect.fromLTRB(
      rect.left - hp,
      rect.top + verticalPadding,
      rect.right + hp,
      rect.bottom - verticalPadding,
    );

    // Perfect stadium corners
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(rect.height / 2),
    );
    canvas.drawRRect(rrect, _paint);
  }
}
