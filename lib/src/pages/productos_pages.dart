import 'package:flutter/material.dart';
import 'package:flutter_app_carrito/shared/models/product_model.dart';
import 'package:flutter_app_carrito/src/pages/carrito_page.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ProductsPage extends StatefulWidget {
  String name = '';
  List<Product> carrito = [];

  ProductsPage({
    super.key,
    required this.name,
    required this.carrito,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> productos = [];
  List<Product> carrito = [];
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
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                print(jsonEncode(widget.carrito));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CarritoPage(carrito_compras: widget.carrito),
                  ),
                );
              },
            ),
          ],
        ),
        body: productos.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: productos.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: size.height / 1.5,
                            child: Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                textDirection: TextDirection.ltr,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  SizedBox(
                                    width: size.width / 3.5,
                                    child: Image.network(
                                      productos[index].image,
                                      width: size.width / 3.5,
                                      height: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / 2,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          productos[index].title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          textWidthBasis: TextWidthBasis.parent,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          productos[index].description,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                            fontSize: 11,
                                          ),
                                          textWidthBasis: TextWidthBasis.parent,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'S/. ${productos[index].price}',
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 45,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              print("Carrito de compras");
                                              print(
                                                  '${widget.carrito.length} 0');
                                              setState(() {
                                                if (widget.carrito.length ==
                                                    0) {
                                                  Product carr_data = Product(
                                                      id: productos[index].id,
                                                      title: productos[index]
                                                          .title,
                                                      price: productos[index]
                                                          .price,
                                                      description:
                                                          productos[index]
                                                              .description,
                                                      category: productos[index]
                                                          .category,
                                                      image: productos[index]
                                                          .image,
                                                      rating: Rating(
                                                        rate: productos[index]
                                                            .rating
                                                            .rate
                                                            .toDouble(),
                                                        count: productos[index]
                                                            .rating
                                                            .count,
                                                      ),
                                                      cantidad: 1);

                                                  widget.carrito.add(carr_data);
                                                } else {
                                                  for (var i = 0;
                                                      i < widget.carrito.length;
                                                      i++) {
                                                    if (productos[index]
                                                            .title ==
                                                        widget
                                                            .carrito[i].title) {
                                                      widget.carrito[i].price++;
                                                      widget.carrito[i]
                                                          .cantidad++;
                                                      break;
                                                    } else {
                                                      Product carr_data =
                                                          Product(
                                                              id: productos[
                                                                      index]
                                                                  .id,
                                                              title: productos[
                                                                      index]
                                                                  .title,
                                                              price: productos[
                                                                      index]
                                                                  .price,
                                                              description:
                                                                  productos[
                                                                          index]
                                                                      .description,
                                                              category:
                                                                  productos[
                                                                          index]
                                                                      .category,
                                                              image: productos[
                                                                      index]
                                                                  .image,
                                                              rating: Rating(
                                                                rate: productos[
                                                                        index]
                                                                    .rating
                                                                    .rate
                                                                    .toDouble(),
                                                                count: productos[
                                                                        index]
                                                                    .rating
                                                                    .count,
                                                              ),
                                                              cantidad: 1);

                                                      widget.carrito
                                                          .add(carr_data);
                                                    }
                                                  }
                                                }
                                              });
                                            },
                                            child:
                                                const Text('AGREGAR A CARRITO'))
                                      ],
                                    ),
                                  ),
                                ],
                                // child: Text(productos[index].description),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 150,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              productos[index].image,
                              width: size.width / 3.5,
                              height: 50,
                            ), // Espacio entre la imagen y el texto
                            Expanded(
                              child: Text(
                                productos[index].title,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}

// Image.network(productos[index].image),
//                           Positioned(
//                             bottom: 0,
//                             left: 0,
//                             right: 0,
//                             child: Container(
//                               color: Colors.black54,
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 8, horizontal: 10),
//                               child: Text(
//                                 (productos[index].title).toUpperCase(),
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),