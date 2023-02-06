import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrine/model/product.dart';
import 'package:shrine/model/products_repository.dart';

class HomePage extends StatelessWidget {
  final Category currentCategory;
  const HomePage({
    Key? key,
    required this.currentCategory
    }) : super(key: key);

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(currentCategory);
    if (products.isEmpty) {
      return [];
    }
    return products.map((product) {
      return _buildGridCard(context, product);
    }).toList();
  }

  Card _buildGridCard(BuildContext context, Product product) {
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    return Card(
      elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: ListView(
          children: <Widget>[
            AspectRatio(
                aspectRatio: 18 / 11,
                child: Image.asset(product.assetName,
                    package: product.assetPackage, fit: BoxFit.fitWidth)),
            const SizedBox(height: 8),
            Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(product.name,
                          style: theme.textTheme.button, maxLines: 1),
                      const SizedBox(height: 4),
                      Text(formatter.format(product.price),
                          style: theme.textTheme.caption)
                    ])
          ],
        ));
  }

  // TODO: Make a collection of cards (102)
  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 8 / 7,
        children: _buildGridCards(context),
      );
  }
}
