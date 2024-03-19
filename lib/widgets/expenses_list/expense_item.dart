import 'package:flutter/material.dart';
import 'package:flutter_app/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {Key? key}) : super(key: key);
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final GlobalKey _backgroundImageKey = GlobalKey();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AspectRatio(
        aspectRatio: 3 / 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              _buildParallaxBackground(context, _backgroundImageKey),
              _buildExpenseContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(
      BuildContext context, GlobalKey backgroundImageKey) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Flow(
          delegate: _ParallaxFlowDelegate(
            scrollable: Scrollable.of(context)!,
            listItemContext: context,
            backgroundImageKey: backgroundImageKey,
          ),
          children: [
            Image.asset(
              categoryImageAsset[expense.category]!,
              key: backgroundImageKey,
              fit: BoxFit.cover,
            ),
          ],
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Theme.of(context).colorScheme.onSecondary.withOpacity(0.5)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expense.title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${expense.amount.toStringAsFixed(2)}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
              Row(
                children: [
                  Icon(
                    categoryIcons[expense.category],
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    expense.formattedDate,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  _ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // scrollFraction = 0 => align top
    // scrollFraction = 1 => align bottom
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background with the calculated offset.
    context.paintChild(
      0,
      transform: Matrix4.translationValues(0, childRect.top, 0),
    );
  }

  @override
  bool shouldRepaint(covariant _ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }
}
