import 'package:flutter/material.dart';
import 'package:flutter_app_carrito/shared/models/product_model.dart';
import 'package:flutter_app_carrito/src/pages/carrito_page.dart';
import 'package:flutter_app_carrito/src/pages/productos_pages.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Categorias> categorias = [
    Categorias(name: "electronics", image: "images/electronica_banner.jpg"),
    Categorias(name: "jewelery", image: "images/joyeria_banner.jpg"),
    Categorias(name: "men's clothing", image: "images/mens_banner.webp"),
    Categorias(name: "women's clothing", image: "images/ropas_banner.jpg"),
  ];

  List<Product> prods = [];
  List<Product> carrito_general = [];
  @override
  void initState() {
    super.initState();
    // main();
  }

  Future<void> main(String name) async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/category/$name'));

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      List<Product> productos = [];

      for (var data in jsonResponse) {
        Product product = Product(
          id: data['id'],
          title: data['title'],
          price: data['price'].toDouble(),
          description: data['description'],
          category: data['category'],
          image: data['image'],
          rating: Rating(
            rate: data['rating']['rate'].toDouble(),
            count: data['rating']['count'],
          ),
        );
        productos.add(product);
      }

      // final responseData = List<String>.from(jsonResponse.map((e) {
      //   return e;
      // }));
    } else {
      print('Error al hacer la solicitud: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tienda"),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                print(jsonEncode(carrito_general));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CarritoPage(carrito_compras: carrito_general),
                  ),
                );
              },
            ),
          ],
        ),
        body: categorias.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: categorias.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsPage(
                              name: categorias[index].name,
                              carrito: carrito_general),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: size.width,
                      child: Stack(
                        children: [
                          Image.asset(categorias[index].image),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              child: Text(
                                (categorias[index].name).toUpperCase(),
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
              ));
  }
}

class Categorias {
  final String name;
  final String image;

  Categorias({required this.name, required this.image});
}
