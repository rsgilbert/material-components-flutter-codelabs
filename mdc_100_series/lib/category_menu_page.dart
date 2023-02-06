import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shrine/colors.dart';
import 'package:shrine/model/product.dart';

class CategoryMenuPage extends StatelessWidget {
  final Category currentCategory;
  final ValueChanged<Category> onCategoryTap;
  final List<Category> _categories = Category.values;

  const CategoryMenuPage({
    Key? key,
    required this.currentCategory,
    required this.onCategoryTap
  }) : super(key: key);

  Widget _buildCategory(Category category, BuildContext context) {
    final categoryString = category.toString().replaceAll('Category.', '').toUpperCase();
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: ()=>onCategoryTap(category),
      child: category == currentCategory 
        ? Column(
          children: [
            const SizedBox(height: 16),
            Text(
              categoryString,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            Container(
              width: 70,
              height: 2,
              color: kShrinePurple,
            )
          ],
        )
        : Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            categoryString,
            textAlign: TextAlign.center,
            ))
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 40),
        decoration: const BoxDecoration(color: kShrinePurple),
        child: ListView(
          children: _categories
            .map((Category c) => _buildCategory(c, context)).toList()
        )
    );
  }
}