
 class ProductAdd{

String? sellerId;
String? name;
String? detail;

var price;
String? image;
int? categoryId;
int? brandId;
int? carModelId;
int? status;

ProductAdd(
    {
      this.sellerId,
      this.name,
      this.detail,

      this.price,
      this.image,
      this.categoryId,
      this.brandId,
      this.status});

ProductAdd.fromJson(Map<String, dynamic> json) {

sellerId = json['sellerId'];
name = json['name'];
detail = json['detail'];
carModelId = json['carModelId'];
price = json['price'];
image = json['image'];
categoryId = json['categoryId'];
brandId = json['brandId'];
status = json['status'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();

  data['sellerId'] = this.sellerId;
  data['name'] = this.name;
  data['detail'] = this.detail;

  data['price'] = this.price;
  data['image'] = this.image;

  data['categoryId'] = this.categoryId;
  data['brandId'] = this.brandId;
  data['status'] = this.status;

  return data;
}}