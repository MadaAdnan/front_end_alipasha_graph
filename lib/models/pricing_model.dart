class PricingModel {
  double? weight;
  double? size;
  double? internal_price;
  double? external_price;

  PricingModel(
      {this.size, this.external_price, this.internal_price, this.weight});

  factory PricingModel.fromJson(Map<String, dynamic> data) {
    return PricingModel(
      external_price: double.tryParse("${data['external_price'] ?? 0}"),
      weight: double.tryParse("${data['weight'] ?? 0}"),
      internal_price: double.tryParse("${data['internal_price'] ?? 0}"),
      size: double.tryParse("${data['size'] ?? 0}") ?? 0,
    );
  }

  toJson() {
    return {
      'external_price': external_price, 'internal_price': internal_price,
    };
  }
}
