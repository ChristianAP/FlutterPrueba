import 'package:flutter/material.dart';
import 'package:flutter_app_carrito/shared/models/product_model.dart';

class AlertDeleteProductOfCartShopping extends StatelessWidget {
  const AlertDeleteProductOfCartShopping({
    Key? key,
    required this.onconfirmed,
    required this.productospe,
  }) : super(key: key);

  final Product productospe;
  final Function onconfirmed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Seguro que desea Eliminar?"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  "Vas a eliminar un producto si confirmas se eliminara del carrito de compras"),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 150,
                      height: 50,
                      color: Colors.blue,
                      child: const Center(
                        child: Text("Cancelar"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  GestureDetector(
                    onTap: () {
                      onconfirmed();
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      color: Colors.red,
                      child: const Center(
                        child: Text("Eliminar"),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
