import 'package:flutter/cupertino.dart';
import 'menu_item.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuItem item;
  final bool isSubItem;
  final VoidCallback? onTap;

  const MenuItemWidget({
    Key? key,
    required this.item,
    this.isSubItem = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isSubItem ? CupertinoColors.systemGrey6 : CupertinoColors.activeBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(_getIconData(item.iconData as String), color: isSubItem ? CupertinoColors.systemGrey : CupertinoColors.white),
            const SizedBox(width: 16.0),
            Text(
              item.title,
              style: TextStyle(
                color: isSubItem ? CupertinoColors.systemGrey : CupertinoColors.white,
                fontSize: 16.0,
              ),
            ),
            const Spacer(),
            if (item.subItems.isNotEmpty)
              RotationTransition(
                turns: AlwaysStoppedAnimation(item.isExpanded ? 0.25 : 0),
                child: Icon(CupertinoIcons.chevron_down, color: isSubItem ? CupertinoColors.systemGrey : CupertinoColors.white),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    // Map your iconName to the corresponding IconData
    switch (iconName) {
      case 'speedometer':
        return CupertinoIcons.speedometer;
    // Add other iconName cases here
      default:
        return CupertinoIcons.question;
    }
  }
}
