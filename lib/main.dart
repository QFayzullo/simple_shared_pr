import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp( ProductListPage());
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<String> _products = [];

  @override
  void initState() {
    super.initState();
    _loadSavedProducts();
  }

  Future<void> _loadSavedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final savedProducts = prefs.getStringList('products') ?? [];
    setState(() {
      _products = savedProducts;
    });
  }

  Future<void> _saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('products', _products);
  }

  void _addProduct() {
    setState(() {
      _products.add('Product ${_products.length + 1}');
    });
    _saveProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
        ),
        body: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            final product = _products[index];
            return ListTile(
              title: Text(product),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addProduct,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
