class ProductModel {
  final String title;
  final String image;

  ProductModel({
    required this.title,
    required this.image,
  });

  factory ProductModel.fromData(Map data) {
    return ProductModel(
      title: data["title"] ?? "Product Title",
      image: data["image"] ?? "Product Title",
    );
  }
}
