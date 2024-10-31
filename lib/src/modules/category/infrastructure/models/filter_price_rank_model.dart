class FilterPriceRankModel {
  int? minPrice;
  int? maxPrice;
  List<String>? rankNames;

  FilterPriceRankModel(
      {required this.minPrice,
      required this.maxPrice,
      required this.rankNames});
}
