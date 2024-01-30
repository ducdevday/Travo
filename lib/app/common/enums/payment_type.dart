enum TypePayment {
  miniMarket,
  card,
  bankTransfer;

  String toJson() => name;

  static TypePayment fromJson(String json) => values.byName(json);
}