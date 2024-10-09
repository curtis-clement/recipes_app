import 'package:flutter/material.dart';
import 'package:recipes_app/data/dummy_data.dart';
import 'package:recipes_app/widgets/category_grid_item.dart';
import 'package:recipes_app/pages/meals_page.dart';
import 'package:recipes_app/models/category.dart';
import 'package:recipes_app/models/meal.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCateogry(BuildContext context, Category category) {
    final meals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    final route = MaterialPageRoute(
        builder: (ctx) => MealsPage(title: category.title, meals: meals));
    Navigator.push(
        context, route); // Same as Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCateogry(context, category);
            },
          ),
        ],
      ),
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(
          top: 100 - _animationController.value * 100,
        ),
        child: child,
      ),
    );
  }
}
