enum ProductC2CStatus {
  public,
  sold,
}

String getProductC2CStatus(ProductC2CStatus type) {
  switch (type) {
    case ProductC2CStatus.public:
      return 'PUBLIC';
    case ProductC2CStatus.sold:
      return 'SOLD';
    default:
      return 'PUBLIC';
  }
}