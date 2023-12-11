class Product {
  final int id;
  final String name;
  final String price;
  final bool availability;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.availability,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        availability: json["availability"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "availability": availability,
      };
}
