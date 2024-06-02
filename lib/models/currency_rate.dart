class CurrencyRates {
  CurrencyRates({
    required this.disclaimer,
    required this.license,
    required this.timestamp,
    required this.base,
    required this.rates,
  });

  final String? disclaimer;
  final String? license;
  final int? timestamp;
  final String? base;
  final Map<String, double> rates;

  factory CurrencyRates.fromJson(Map<String, dynamic> json) {
    return CurrencyRates(
      disclaimer: json["disclaimer"],
      license: json["license"],
      timestamp: json["timestamp"],
      base: json["base"],
      rates: Map<String, double>.from(
        json["rates"].map((key, value) => MapEntry(
          key,
          value is int ? value.toDouble() : value,
        )),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "disclaimer": disclaimer,
    "license": license,
    "timestamp": timestamp,
    "base": base,
    "rates": Map<String, dynamic>.from(rates),
  };
}
