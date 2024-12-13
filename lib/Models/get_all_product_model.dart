class GetAllProductModel {
  String? message;
  int? count;
  List<Products>? products;

  GetAllProductModel({this.message, this.count, this.products});

  GetAllProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
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

  // Factory constructor for parsing JSON
  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    plateNo = json['plateNo'];
    price = json['price'];
    discountpercent = json['discountpercent'];
    discountedPrice = json['discountedPrice'] is int
        ? (json['discountedPrice'] as int).toDouble()
        : (json['discountedPrice'] as double?);
    availability = json['availability'];
    seller = json['seller'];
    likes = List<String>.from(json['likes'] ?? []);
    views = json['views'];
    createdAt = json['created_at'];
    iV = json['__v'];
    sellerName = json['sellerName'];
  }

  // Convert to JSON
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


