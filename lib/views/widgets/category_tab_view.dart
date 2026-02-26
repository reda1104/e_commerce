import 'package:e_commerce/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyCategories.length,
      itemBuilder: (context, index) {
        final category = dummyCategories[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: InkWell(
            onTap: () => {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: category.bgColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32.0,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    Text(
                      category.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "${category.productCount} products",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
