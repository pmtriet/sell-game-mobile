import '../../infrastructure/models/filter_price_rank_model.dart';

class FilterResult {
  final FilterPriceRankModel? data;
  final FilterAction action;

  FilterResult({this.data, required this.action});
}

enum FilterAction {
  apply,
  clear
}