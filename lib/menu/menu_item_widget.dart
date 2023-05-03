import 'package:flutter/cupertino.dart';
import 'menu_item.dart';

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
            Icon(item.iconData, color: isSubItem ? CupertinoColors.systemGrey : CupertinoColors.white), // Remove the cast
            const SizedBox(width: 16.0),
            Text(
              item.title,
              style: TextStyle(
                color: isSubItem ? CupertinoColors.systemGrey : CupertinoColors.white,
                fontSize: 16.0,
              ),
            ),
            const Spacer(),
            if (item.subItems?.isNotEmpty ?? false)
              RotationTransition(
                turns: AlwaysStoppedAnimation(item.isExpanded ? 0.25 : 0),
                child: Icon(CupertinoIcons.chevron_down, color: isSubItem ? CupertinoColors.systemGrey : CupertinoColors.white),
              ),
          ],
        ),
      ),
    );
  }
}
