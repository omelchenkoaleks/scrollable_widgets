import 'package:flutter/material.dart';
import 'package:scrollable_widgets/screens/explore_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/grocery_screen.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Wraps all the widgets inside Consumer. When TabManager changes, the widgets below it will rebuild.
    return Consumer<TabManager>(
      builder: (context, tabManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Fooderlich',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          // Displays the correct page widget, based on the current tab index.
          body: pages[tabManager.selectedTab],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            // Sets the current index of BottomNavigationBar.
            currentIndex: tabManager.selectedTab,
            onTap: (index) {
              // Calls manager.goToTab() when the user taps a different tab, to notify other widgets that the index changed.
              tabManager.goToTab(index);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'To Buy',
              ),
            ],
          ),
        );
      },
    );
  }
}
