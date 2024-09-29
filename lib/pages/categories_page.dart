import 'package:flutter/material.dart';
import 'package:recipes_app/data/dummy_data.dart';
import 'package:recipes_app/widgets/category_grid_item.dart';
import 'package:recipes_app/pages/meals_page.dart';
import 'package:recipes_app/models/category.dart';
import 'package:recipes_app/models/meal.dart';
class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key, required this.onToggleFavorite, required this.availableMeals});

  final void Function(Meal) onToggleFavorite;
  final List<Meal> availableMeals;
  
  void _selectCateogry(BuildContext context, Category category) {
    final meals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    final route = MaterialPageRoute(
        builder: (ctx) => MealsPage(title: category.title, meals: meals, onToggleFavorite: onToggleFavorite));
    Navigator.push(
        context, route); // Same as Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
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
    );
  }
}
