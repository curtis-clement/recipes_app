import 'package:flutter/material.dart';
import 'package:recipes_app/models/meal.dart';
import 'package:recipes_app/widgets/meal_item.dart';
import 'package:recipes_app/pages/meal_details_page.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;
  
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => MealDetailsPage(meal: meal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal) => selectMeal(context, meal)),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          children: [
            Text(
              'No meals found...',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
