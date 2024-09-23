import 'package:flutter/material.dart';
import 'package:recipes_app/pages/categories_page.dart';
import 'package:recipes_app/pages/meals_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesPage();

    if (_selectedPageIndex == 1) {
      activePage = const MealsPage(title: 'Favorites', meals: []);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('dynamic...'),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),

        ],
      ),
    );
  }
}