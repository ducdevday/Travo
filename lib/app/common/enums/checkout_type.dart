enum CheckoutType {
  hotel,
  flight;

  String toJson() => name;

  static CheckoutType fromJson(String json) => values.byName(json);
}
