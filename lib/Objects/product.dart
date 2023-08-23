class Product {
  final String id; //Primary key
  String name;
  String? desc;
  double discount;
  int inStock;
  //Maybe category can be enum?
  List<String>? mainCategory;
  List<String>? subCategory;
  double price;
  List<String>? images;

  final String supplierID; //Foreign keys
  Product({
    required this.id,
    required this.name,
    this.desc = '',
    this.discount = 0,
    this.inStock = 0,
    this.mainCategory,
    this.subCategory,
    required this.price,
    this.images,
    required this.supplierID,
  });

  //TODO: toJSON and fromJSON function
}
