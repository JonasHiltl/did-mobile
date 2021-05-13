import 'package:did/screens/page2/page2.dart';
import 'package:did/screens/home/home.dart';
import 'package:did/screens/page3/page3.dart';
import 'package:flutter/material.dart';

class SessionNavigator extends StatefulWidget {
  @override
  _SessionNavigatorState createState() => _SessionNavigatorState();
}

class _SessionNavigatorState extends State<SessionNavigator> {
  String _currentPage = "Home";
  List<String> pageKeys = ["Home", "Page2", "Page3"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Home") {
            _selectTab("Home", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator("Home"),
            _buildOffstageNavigator("Page2"),
            _buildOffstageNavigator("Page3"),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Page1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_two),
              label: 'Page2',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_3),
              label: 'Page3',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Home") {
      child = Home();
    } else if (tabItem == "Page2") {
      child = Page2();
    } else {
      child = Page3();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
