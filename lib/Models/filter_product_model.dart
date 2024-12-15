class FilterProduct {
  final String? id;
  final String? name;
  final String? price;
  final String? description;

  FilterProduct({ this.id,  this.name,  this.price,  this.description});

  factory FilterProduct.fromJson(Map<String, dynamic> json) {
    return FilterProduct(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }
}
