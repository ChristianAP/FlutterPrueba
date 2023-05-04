import 'package:flutter/material.dart';
import 'package:flutter_app_carrito/shared/models/product_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ProductsPage extends StatefulWidget {
  String name = '';

  ProductsPage({super.key, required this.name});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> productos = [];
  @override
  void initState() {
    super.initState();
    main(widget.name);
  }

  Future<void> main(String name) async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/category/$name'));

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      // List<Product> products = []; // Crear una lista temporal de productos

      // for (var data in jsonResponse) {
      //   print(data);
      //   Product product = Product(
      //     id: data['id'],
      //     title: data['title'],
      //     price: data['price'].toDouble(),
      //     description: data['description'],
      //     category: data['category'],
      //     image: data['image'],
      //     rating: Rating(
      //       rate: data['rating']['rate'].toDouble(),
      //       count: data['rating']['count'],
      //     ),
      //   );
      //   products.add(product);
      // }

      final products = List<Product>.from(jsonResponse.map((data) {
        print(data);
        return Product(
          id: data['id'],
          title: data['title'],
          price: data['price'].toDouble(),
          description: data['description'],
          category: data['category'],
          image: data['image'],
          rating: data['rating'] != null
              ? Rating(
                  rate: data['rating']['rate'].toDouble(),
                  count: data['rating']['count'],
                )
              : Rating(rate: 0, count: 0),
        );
      }));

      setState(() {
        productos = products; // Agregar los productos a la lista principal
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("PRODUCTOS"),
        ),
        body: productos.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: productos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 150,
                    width: size.width,
                    child: Stack(
                      children: [
                        Image.network(productos[index].image),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: Text(
                              (productos[index].title).toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ));
  }
}
