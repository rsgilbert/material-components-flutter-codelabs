import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrine/model/product.dart';
import 'package:shrine/model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
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
        clipBehavior: Clip.antiAlias,
        child: ListView(
          children: <Widget>[
            AspectRatio(
                aspectRatio: 18 / 11, 
                child: Image.asset(
                  product.assetName, 
                  package: product.assetPackage,
                  fit: BoxFit.fitWidth
                )
              ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: theme.textTheme.headline6,
                        maxLines: 1
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatter.format(product.price),
                        style: theme.textTheme.subtitle2
                      )
                    ]))
          ],
        ));
  }

  // TODO: Make a collection of cards (102)
  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            semanticLabel: 'Menu',
          ),
          onPressed: () {
            print("Menu buton");
          },
        ),
        title: const Text("SHRINE"),
        actions: [
          IconButton(
              onPressed: () {
                print("Searching");
              },
              icon: const Icon(Icons.search, semanticLabel: "Search")),
          IconButton(
              onPressed: () {
                print("Filtering");
              },
              icon: const Icon(Icons.filter_alt_sharp, semanticLabel: "Filter"))
        ],
      ),
      // TODO: Add a grid view (102)
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 8 / 9,
        children: _buildGridCards(context),
      ),
      resizeToAvoidBottomInset: false,
      // TODO: Set resizeToAvoidBottomInset (101)
    );
  }
}
