import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'menu_item_widget.dart';
import 'menu_item.dart';

class MainMenu extends StatelessWidget {
  final List<MenuItem> menuItems;
  final Function(MenuItem) onMenuItemSelected;

  const MainMenu({
    Key? key,
    required this.menuItems,
    required this.onMenuItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Menu'),
      ),
      child: Builder(builder: (context) {
        return CupertinoScrollbar(
          child: ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (BuildContext context, int index) {
              final item = menuItems[index];

              if (item.subItems.isEmpty) {
                return MenuItemWidget(
                  item: item,
                  onTap: () => onMenuItemSelected(item),
                );
              } else {
                return _buildCupertinoExpansionTile(context, item);
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildCupertinoExpansionTile(BuildContext context, MenuItem item) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.blue,
        ),
      ),
      child: Column(
        children: [
          CupertinoContextMenu(
            actions: item.subItems
                .map((subItem) => _buildContextMenuItem(context, subItem))
                .toList(),
            child: CupertinoButton(
              onPressed: () {
                item.isExpanded = !item.isExpanded;
                if(item.isExpanded){
                  HapticFeedback.mediumImpact();
                } else {
                  HapticFeedback.lightImpact();
                }
              },
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Expanded(
                    child: MenuItemWidget(
                      item: item,
                      onTap: () => onMenuItemSelected(item),
                    ),
                  ),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(
                      item.isExpanded ? 0.25 : 0,
                    ),
                    child: const Icon(
                      CupertinoIcons.chevron_down,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (item.isExpanded)
            Column(
              children: item.subItems
                  .map((subItem) => MenuItemWidget(
                item: subItem,
                isSubItem: true,
                onTap: () => onMenuItemSelected(subItem),
              ))
                  .toList(),
            ),
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: CupertinoColors.systemGrey4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContextMenuItem(BuildContext context, MenuItem item) {
    return CupertinoContextMenuAction(
      child: MenuItemWidget(item: item),
      onPressed: () => onMenuItemSelected(item),
    );
  }
}
