import 'package:flutter/material.dart';
import 'package:flutter_app_carrito/shared/models/product_model.dart';
import 'package:flutter_app_carrito/src/pages/alert_delete_product.dart';

class CarritoPage extends StatefulWidget {
  List<Product> carrito_compras = [];
  CarritoPage({super.key, required this.carrito_compras});

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  void deleteProduct(Product producto) {
    setState(() {
      widget.carrito_compras.remove(producto);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('CARRITO DE COMPRAS'),
        ),
        body: widget.carrito_compras.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: widget.carrito_compras.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDeleteProductOfCartShopping(
                          onconfirmed: () =>
                              deleteProduct(widget.carrito_compras[index]),
                          productospe: widget.carrito_compras[index],
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: size.width,
                      child: Stack(
                        children: [
                          Image.network(widget.carrito_compras[index].image),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              child: Text(
                                (widget.carrito_compras[index].title)
                                    .toUpperCase(),
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
