class ProducteModel {
  int? id;
  String? sellerId;
  String? name;
  String? detail;
  String? timeDelivery;
  bool? detailsPrice;
  bool? isCart;
  bool? isFav;
  var price;
  String? image;
  
  int? categoryId;
   int? carModelId;
  int? brandId;
  int? offerId;
  int? status;

  ProducteModel(
      {this.id,
        this.sellerId,
        this.name,
        this.detail,
        this.isCart,
        this.isFav,
        this.detailsPrice,
        this.timeDelivery,
        this.offerId,
        this.price,
        this.image,
        this.categoryId,
        this.carModelId,
        this.brandId,
        this.status});

  ProducteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['sellerId'];
    name = json['name'];
    detail = json['detail'];
    isCart = json['isCart'];
    isFav = json['isFav'];
    detailsPrice = json['detailsPrice'];
    timeDelivery = json['timeDelivery'];
    offerId = json['offerId'];
    price = json['price'];
    image = json['image'];
    categoryId = json['categoryId'];
    brandId = json['brandId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sellerId'] = this.sellerId;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['isCart'] = this.isCart;
    data['isFav'] = this.isFav;
    data['price'] = this.price;
    data['image'] = this.image;
    data['detailsPrice'] = this.detailsPrice;
    data['timeDelivery'] = this.timeDelivery;
    data['categoryId'] = this.categoryId;
    data['brandId'] = this.brandId;
    data['status'] = this.status;
      data['offerId'] =offerId;
    return data;
  }
}
