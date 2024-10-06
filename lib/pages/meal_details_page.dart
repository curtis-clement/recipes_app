import 'package:flutter/material.dart';
import 'package:recipes_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app/providers/favorites_provider.dart';

class MealDetailsPage extends ConsumerWidget {
  const MealDetailsPage({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final isFavorite = ref.read(favoritesProvider.notifier).toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(isFavorite ? 'Meal added to favorites' : 'Meal removed from favorites')));
            },
            icon: const Icon(Icons.star),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            for (final ingredient in meal.ingredients) Text(ingredient),
            const SizedBox(height: 24),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            for (final step in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
