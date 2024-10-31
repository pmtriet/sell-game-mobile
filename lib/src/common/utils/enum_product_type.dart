enum ProductType {
  b2c,
  c2c,
}

ProductType getProductTypeFromString(String type) {
  switch (type) {
    case 'B2C':
      return ProductType.b2c;
    case 'C2C':
      return ProductType.c2c;
    default:
      return ProductType.b2c;
  }
}

String getStringFromProductType(ProductType type) {
  switch (type) {
    case ProductType.b2c:
      return 'B2C';
    case ProductType.c2c:
      return 'C2C';
    default:
      return 'B2C';
  }
}