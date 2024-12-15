class GetAllProductsModel {
  String? message;
  int? count;
  List<Products>? products;

  GetAllProductsModel({this.message, this.count, this.products});

  factory GetAllProductsModel.fromJson(Map<String, dynamic> json) {
    return GetAllProductsModel(
      message: json['message'],
      count: json['count'],
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'count': count,
      'products': products?.map((e) => e.toJson()).toList(),
    };
  }
}

class Products {
  String? sId;
  String? category;
  String? plateNo;
  int? price;
  int? discountpercent;
  double? discountedPrice;
  String? availability;
  String? seller;
  List<String>? likes;
  int? views;
  String? createdAt;
  int? iV;
  String? sellerName;

  Products({
    this.sId,
    this.category,
    this.plateNo,
    this.price,
    this.discountpercent,
    this.discountedPrice,
    this.availability,
    this.seller,
    this.likes,
    this.views,
    this.createdAt,
    this.iV,
    this.sellerName,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      sId: json['_id'],
      category: json['category'],
      plateNo: json['plateNo'],
      price: json['price'],
      discountpercent: json['discountpercent'],
      discountedPrice: (json['discountedPrice'] is int)
          ? (json['discountedPrice'] as int).toDouble()
          : (json['discountedPrice'] as double?),
      availability: json['availability'],
      seller: json['seller'],
      likes: List<String>.from(json['likes'] ?? []),
      views: json['views'],
      createdAt: json['created_at'],
      iV: json['__v'],
      sellerName: json['sellerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'category': category,
      'plateNo': plateNo,
      'price': price,
      'discountpercent': discountpercent,
      'discountedPrice': discountedPrice,
      'availability': availability,
      'seller': seller,
      'likes': likes,
      'views': views,
      'created_at': createdAt,
      '__v': iV,
      'sellerName': sellerName,
    };
  }
}
