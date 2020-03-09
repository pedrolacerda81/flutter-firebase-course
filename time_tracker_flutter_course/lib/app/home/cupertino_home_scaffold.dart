import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/tab_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;

  const CupertinoHomeScaffold(
      {Key key,
      @required this.currentTab,
      @required this.onSelectTab,
      @required this.widgetBuilders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        onTap: (int index) => onSelectTab(TabItem.values[index]),
        //enum values can be accessed by index
        items: [
          _buildItem(TabItem.jobs),
          _buildItem(TabItem.entries),
          _buildItem(TabItem.account),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        final TabItem item = TabItem.values[index];
        return CupertinoTabView(
          builder: (BuildContext context) => widgetBuilders[item](context),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final TabItemData tabItemData = TabItemData.allTabs[tabItem];
    final Color color = currentTab == tabItem ? Colors.indigo : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        tabItemData.icon,
        color: color,
      ),
      title: Text(
        tabItemData.title,
        style: TextStyle(color: color),
      ),
    );
  }
}
