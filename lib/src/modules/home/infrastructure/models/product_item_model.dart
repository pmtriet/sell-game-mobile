class ProductItemModel {
  final int id;
  final String description;
  final String createdTime;
  final String categoryName;
  final int price;
  final int discountPercent;
  final String img;

  ProductItemModel(
      {required this.id,
      required this.description,
      required this.createdTime,
      required this.categoryName,
      required this.price,
      required this.discountPercent,
      required this.img});
}
