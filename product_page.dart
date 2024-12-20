import 'package:flutter/material.dart';
import 'package:api_product/services/api_service.dart';


class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      final fetchedProducts = await ApiService.getProducts();
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print('Failed to fetch products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width to adjust layout
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of columns based on screen width
    int crossAxisCount = screenWidth > 600 ? 3 : 1; // 1 column for smaller screens, 3 for larger screens

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Showcase'),
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image section
                Expanded(
                  child: Image.network(
                    product['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                // Title section
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 18 : 16, // Adjust font size based on screen width
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Price section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '\$${product['price'].toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth > 600 ? 16 : 14, // Adjust price font size for responsiveness
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
