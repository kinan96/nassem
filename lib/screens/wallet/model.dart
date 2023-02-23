// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

class WalletStatusId {
  static const int indebtedness = 0;
  static const int cash = 1;
  static const int onlineRequests = 2;
  static const int total = 3;
  static String name(int id) {
    switch (id) {
      case indebtedness:
        return "indebtedness";
      case cash:
        return "all-cash";
      case onlineRequests:
        return "all-online";
      case total:
        return "all-total";
      default:
        return "all-total";
    }
  }
}

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  WalletModel({
    this.value,
    this.sales,
  });

  double? value;
  List<Sale>? sales;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        value: json["value"]?.toDouble(),
        sales: json["sales"] == null
            ? []
            : List<Sale>.from(json["sales"]!.map((x) => Sale.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "sales": sales == null
            ? []
            : List<dynamic>.from(sales!.map((x) => x.toJson())),
      };
}

class Sale {
  Sale({
    this.theDay,
    this.total,
  });

  DateTime? theDay;
  double? total;

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        theDay:
            json["the_day"] == null ? null : DateTime.parse(json["the_day"]),
        total: json["total"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "the_day":
            "${theDay!.year.toString().padLeft(4, '0')}-${theDay!.month.toString().padLeft(2, '0')}-${theDay!.day.toString().padLeft(2, '0')}",
        "total": total,
      };
}
