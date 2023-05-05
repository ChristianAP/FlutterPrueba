// To parse this JSON data, do
//
//     final carrito = carritoFromJson(jsonString);

import 'dart:convert';

List<Carrito> carritoFromJson(String str) =>
    List<Carrito>.from(json.decode(str).map((x) => Carrito.fromJson(x)));

String carritoToJson(List<Carrito> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carrito {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;
  int cantidad;

  Carrito({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.cantidad,
  });

  factory Carrito.fromJson(Map<String, dynamic> json) => Carrito(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
        "cantidad": cantidad,
      };
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
