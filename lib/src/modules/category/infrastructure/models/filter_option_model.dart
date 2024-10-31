import 'filter_price_rank_model.dart';

class FilterOptionModel {
  bool? filterByNewest;
  bool? filterBySale;
  bool filterByPrice;//true: low to high, false: high to low
  FilterPriceRankModel? filterByPriceRankModel;

  FilterOptionModel(
      {required this.filterByNewest,
      required this.filterBySale,
      required this.filterByPrice,
      required this.filterByPriceRankModel});
}
