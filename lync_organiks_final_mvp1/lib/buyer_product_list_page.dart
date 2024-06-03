import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Product {
  final String pid;
  final String productName;
  final String category;

  Product({required this.pid, required this.productName, required this.category});
}

class ProductService {
  final Dio dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await dio.get(
        'http://lyncorganik-env.eba-skd53vix.ap-south-1.elasticbeanstalk.com/organic/cropdetails/getall',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 302) {
        final List<dynamic> data = response.data;
        return data.map((json) => Product(
          pid: json['pid'].toString(),
          productName: json['name'],
          category: json['category'],
        )).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Failed to load products');
    }
  }
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> productFuture;
  late List<Product> products;
  late List<Product> filteredProducts;
  late TextEditingController searchController;
  late String selectedCategory;
  late List<String> uniqueCategories;

  @override
  void initState() {
    super.initState();
    productFuture = fetchProducts();
    products = [];
    filteredProducts = [];
    searchController = TextEditingController();
    selectedCategory = 'All';
    uniqueCategories = [];
  }

  Future<List<Product>> fetchProducts() async {
    try {
      final productService = ProductService();
      final fetchedProducts = await productService.fetchProducts();
      setState(() {
        products = fetchedProducts;
        uniqueCategories = products.map((product) => product.category).toSet().toList();
        uniqueCategories.insert(0, 'All');
        applyFilters();
      });
      return fetchedProducts;
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Failed to load products');
    }
  }

  void applyFilters() {
    filteredProducts = products.where((product) {
      final productNameMatches = product.productName.toLowerCase().contains(searchController.text.toLowerCase());
      final categoryMatches = selectedCategory == 'All' || product.category == selectedCategory;
      return productNameMatches && categoryMatches;
    }).toList();
  }

  String getImageForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'pulses':
        return 'images/p1.png';
      case 'grain/ cereals/rice':
        return 'images/p2.png';
      case 'flour/ daliya':
        return 'images/p3.png';
      case 'super seed/ dry fruits':
        return 'images/p4.png';
      case 'oil/ ghee':
        return 'images/p5.png';
      case 'spices/ herbs':
        return 'images/p6.png';
      case 'sweetner':
        return 'images/p7.png';
      default:
        return 'images/default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Product Page',
              style: TextStyle(color: Colors.black87),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search products',
                          prefixIcon: Icon(Icons.search, color: Color(0xFF84C86D)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            applyFilters();
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: PopupMenuButton<String>(
                      icon: Icon(Icons.filter_list, color: Color(0xFF84C86D)),
                      onSelected: (String value) {
                        setState(() {
                          selectedCategory = value;
                          applyFilters();
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        return [...uniqueCategories].map((String category) {
                          return PopupMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<Product>>(
                  future: productFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF84C86D))
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error loading products'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('No products available'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
                                  print('Clicked on ${product.productName}');
                                },
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.asset(
                                    getImageForCategory(product.category),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(product.productName),
                                subtitle: Text(product.category),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
