enum SuggestProductType {
  shopProducts,
  suggestProducts,
}

SuggestProductType getSuggestProductTypeFromString(String type) {
  switch (type) {
    case 'TIN KHÁC TỪ NGƯỜI BÁN':
      return SuggestProductType.shopProducts;
    case 'ĐỀ XUẤT CHO BẠN':
      return SuggestProductType.suggestProducts;
    default:
      return SuggestProductType.suggestProducts;
  }
}