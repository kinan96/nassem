import 'dart:convert';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:nassem/public_models/user_model.dart';

class OrderTypeId {
  static const int delivering = 0;
  static const int stalled = 1;
  static const int delivered = 2;
}

class OrderPaymentMethod {
  static const cash = "cash_on_delivery";
  static const online = "e_pay";
  static const wallet = "wallet";
}

getPaymentMethodName(String? key) {
  switch (key) {
    case OrderPaymentMethod.cash:
      return "payment_upon_receipt".tr;
    case OrderPaymentMethod.online:
      return "online".tr;
    case OrderPaymentMethod.wallet:
      return "wallet".tr;

    default:
      return "online".tr;
  }
}
// To parse this JSON data, do
//
//     final allOrdersModel = allOrdersModelFromJson(jsonString?);

AllOrdersModel allOrdersModelFromJson(String? str) =>
    AllOrdersModel.fromJson(json.decode(str!));

String? allOrdersModelToJson(AllOrdersModel data) => json.encode(data.toJson());

class AllOrdersModel {
  AllOrdersModel({
    this.list = const [],
    this.paginate,
  });

  List<OrderModel> list;
  Paginate? paginate;

  factory AllOrdersModel.fromJson(Map<String?, dynamic> json) => AllOrdersModel(
        list: List<OrderModel>.from(
            json["list"].map((x) => OrderModel.fromJson(x))),
        paginate: Paginate.fromJson(json["paginate"]),
      );

  Map<String?, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "paginate": paginate?.toJson(),
      };
}

// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.id,
    this.status,
    this.statusForHuman,
    this.cancelReason,
    this.missDeliveryReason,
    this.attaches,
    this.user,
    this.messageFrom,
    this.messageTo,
    this.message,
    this.messageUrl,
    this.receiveByMyself,
    this.lat,
    this.lng,
    this.address,
    this.countryId,
    this.cityId,
    this.receiverName,
    this.receiverPhone,
    this.receiverEmail,
    this.unknownAddress,
    this.deliveryDate,
    this.from,
    this.to,
    this.paymentMethod,
    this.referenceNo,
    this.discount,
    this.subTotal,
    this.deliveryFees,
    this.tax,
    this.total,
    this.createdAt,
    this.updatedAt,
    this.branch,
    this.delivery,
    this.orderDetails,
  });

  int? id;
  String? status;
  String? statusForHuman;
  String? cancelReason;
  String? missDeliveryReason;
  List<String>? attaches;
  UserModel? user;
  String? messageFrom;
  String? messageTo;
  String? message;
  String? messageUrl;
  int? receiveByMyself;
  double? lat;
  double? lng;
  String? address;
  CityId? countryId;
  CityId? cityId;
  String? receiverName;
  String? receiverPhone;
  String? receiverEmail;
  int? unknownAddress;
  DateTime? deliveryDate;
  String? from;
  String? to;
  String? paymentMethod;
  String? referenceNo;
  String? discount;
  String? subTotal;
  String? deliveryFees;
  String? tax;
  String? total;
  DateTime? createdAt;
  DateTime? updatedAt;
  Branch? branch;
  Branch? delivery;
  List<OrderDetail>? orderDetails;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        status: json["status"],
        statusForHuman: json["status_for_human"],
        cancelReason: json["cancel_reason"],
        missDeliveryReason: json["miss_delivery_reason"],
        attaches: json["attaches"] == null
            ? []
            : List<String>.from(json["attaches"]!
                .map((x) => x.runtimeType == List ? x.first : x)),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        messageFrom: json["message_from"],
        messageTo: json["message_to"],
        message: json["message"],
        messageUrl: json["message_url"],
        receiveByMyself: json["receive_by_myself"],
        lat: double.tryParse(["lat"].toString()),
        lng: double.tryParse(["lng"].toString()),
        address: json["address"],
        countryId: json["country_id"] == null
            ? null
            : CityId.fromJson(json["country_id"]),
        cityId:
            json["city_id"] == null ? null : CityId.fromJson(json["city_id"]),
        receiverName: json["receiver_name"],
        receiverPhone: json["receiver_phone"],
        receiverEmail: json["receiver_email"],
        unknownAddress: json["unknown_address"],
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        from: json["from"],
        to: json["to"],
        paymentMethod: json["payment_method"],
        referenceNo: json["reference_no"],
        discount: json["discount"],
        subTotal: json["sub_total"],
        deliveryFees: json["delivery_fees"],
        tax: json["tax"],
        total: json["total"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        delivery:
            json["delivery"] == null ? null : Branch.fromJson(json["delivery"]),
        orderDetails: json["order_details"] == null
            ? []
            : List<OrderDetail>.from(
                json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "status_for_human": statusForHuman,
        "cancel_reason": cancelReason,
        "miss_delivery_reason": missDeliveryReason,
        "attaches": attaches,
        "user": user?.toJson(),
        "message_from": messageFrom,
        "message_to": messageTo,
        "message": message,
        "message_url": messageUrl,
        "receive_by_myself": receiveByMyself,
        "lat": lat,
        "lng": lng,
        "address": address,
        "country_id": countryId?.toJson(),
        "city_id": cityId?.toJson(),
        "receiver_name": receiverName,
        "receiver_phone": receiverPhone,
        "receiver_email": receiverEmail,
        "unknown_address": unknownAddress,
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "from": from,
        "to": to,
        "payment_method": paymentMethod,
        "reference_no": referenceNo,
        "discount": discount,
        "sub_total": subTotal,
        "delivery_fees": deliveryFees,
        "tax": tax,
        "total": total,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "branch": branch?.toJson(),
        "delivery": delivery?.toJson(),
        "order_details": orderDetails == null
            ? []
            : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
      };
}

class Branch {
  Branch({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.branchEmail,
    this.lat,
    this.lng,
    this.address,
    this.isSuspended,
    this.suspendReason,
    this.image,
    this.cities,
    this.deliveryCapacities,
    this.position,
    this.token,
  });

  int? id;
  String? name;
  String? phone;
  String? email;
  String? branchEmail;
  String? lat;
  String? lng;
  String? address;
  int? isSuspended;
  String? suspendReason;
  String? image;
  List<City>? cities;
  List<DeliveryCapacity>? deliveryCapacities;
  String? position;
  String? token;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        branchEmail: json["branch_email"],
        lat: json["lat"],
        lng: json["lng"],
        address: json["address"],
        isSuspended: json["is_suspended"],
        suspendReason: json["suspend_reason"],
        image: json["image"],
        cities: json["cities"] == null
            ? []
            : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
        deliveryCapacities: json["delivery_capacities"] == null
            ? []
            : List<DeliveryCapacity>.from(json["delivery_capacities"]!
                .map((x) => DeliveryCapacity.fromJson(x))),
        position: json["position"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "branch_email": branchEmail,
        "lat": lat,
        "lng": lng,
        "address": address,
        "is_suspended": isSuspended,
        "suspend_reason": suspendReason,
        "image": image,
        "cities": cities == null
            ? []
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
        "delivery_capacities": deliveryCapacities == null
            ? []
            : List<dynamic>.from(deliveryCapacities!.map((x) => x.toJson())),
        "position": position,
        "token": token,
      };
}

class City {
  City({
    this.cityId,
    this.name,
  });

  int? cityId;
  String? name;

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "name": name,
      };
}

class DeliveryCapacity {
  DeliveryCapacity({
    this.id,
    this.weekDaysId,
    this.weekDaysName,
    this.weekDaysCode,
    this.from,
    this.to,
    this.capacity,
  });

  int? id;
  int? weekDaysId;
  String? weekDaysName;
  String? weekDaysCode;
  String? from;
  String? to;
  int? capacity;

  factory DeliveryCapacity.fromJson(Map<String, dynamic> json) =>
      DeliveryCapacity(
        id: json["id"],
        weekDaysId: json["week_days_id"],
        weekDaysName: json["week_days_name"]!,
        weekDaysCode: json["week_days_code"]!,
        from: json["from"],
        to: json["to"],
        capacity: json["capacity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "week_days_id": weekDaysId,
        "week_days_name": weekDaysName,
        "week_days_code": weekDaysCode,
        "from": from,
        "to": to,
        "capacity": capacity,
      };
}

class CityId {
  CityId({
    this.id,
    this.arName,
    this.enName,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.country,
  });

  int? id;
  String? arName;
  String? enName;
  int? status;
  String? createdAt;
  DateTime? updatedAt;
  String? image;
  CityId? country;

  factory CityId.fromJson(Map<String, dynamic> json) => CityId(
        id: json["id"],
        arName: json["ar_name"],
        enName: json["en_name"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        image: json["image"],
        country:
            json["country"] == null ? null : CityId.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ar_name": arName,
        "en_name": enName,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
        "image": image,
        "country": country?.toJson(),
      };
}

class OrderDetail {
  OrderDetail({
    this.id,
    this.productPrice,
    this.quantity,
    this.total,
    this.productType,
    this.options,
    this.productDetails,
  });

  int? id;
  String? productPrice;
  int? quantity;
  String? total;
  String? productType;
  List<Option>? options;
  ProductDetails? productDetails;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        productPrice: json["product_price"],
        quantity: json["quantity"],
        total: json["total"],
        productType: json["product_type"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
        productDetails: json["product_details"] == null
            ? null
            : ProductDetails.fromJson(json["product_details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_price": productPrice,
        "quantity": quantity,
        "total": total,
        "product_type": productType,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        "product_details": productDetails?.toJson(),
      };
}

class Option {
  Option({
    this.optionValueId,
    this.optionValueArName,
    this.optionValueEnName,
    this.optionValuePrice,
  });

  int? optionValueId;
  String? optionValueArName;
  String? optionValueEnName;
  String? optionValuePrice;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        optionValueId: json["option_value_id"],
        optionValueArName: json["option_value_ar_name"],
        optionValueEnName: json["option_value_en_name"],
        optionValuePrice: json["option_value_price"],
      );

  Map<String, dynamic> toJson() => {
        "option_value_id": optionValueId,
        "option_value_ar_name": optionValueArName,
        "option_value_en_name": optionValueEnName,
        "option_value_price": optionValuePrice,
      };
}

class ProductDetails {
  ProductDetails({
    this.id,
    this.arName,
    this.enName,
    this.status,
    this.branchAvailability,
    this.arDescription,
    this.enDescription,
    this.thumbnail,
    this.videoProvider,
    this.videoLink,
    this.price,
    this.discountStart,
    this.discountEnd,
    this.discount,
    this.discountType,
    this.metaTitle,
    this.metaDescription,
    this.category,
    this.brand,
    this.occasions,
    this.groups,
    this.optionsValues,
    this.images,
  });

  int? id;
  String? arName;
  String? enName;
  int? status;
  bool? branchAvailability;
  String? arDescription;
  String? enDescription;
  String? thumbnail;
  String? videoProvider;
  String? videoLink;
  String? price;
  DateTime? discountStart;
  DateTime? discountEnd;
  dynamic discount;
  String? discountType;
  String? metaTitle;
  String? metaDescription;
  Brand? category;
  Brand? brand;
  List<Brand>? occasions;
  List<Brand>? groups;
  List<OptionsValue>? optionsValues;
  List<Image>? images;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["id"],
        arName: json["ar_name"],
        enName: json["en_name"],
        status: json["status"],
        branchAvailability: json["branch_availability"],
        arDescription: json["ar_description"],
        enDescription: json["en_description"],
        thumbnail: json["thumbnail"],
        videoProvider: json["video_provider"],
        videoLink: json["video_link"],
        price: json["price"],
        discountStart: json["discount_start"] == null
            ? null
            : DateTime.parse(json["discount_start"]),
        discountEnd: json["discount_end"] == null
            ? null
            : DateTime.parse(json["discount_end"]),
        discount: json["discount"],
        discountType: json["discount_type"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        category:
            json["category"] == null ? null : Brand.fromJson(json["category"]),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        occasions: json["occasions"] == null
            ? []
            : List<Brand>.from(
                json["occasions"]!.map((x) => Brand.fromJson(x))),
        groups: json["groups"] == null
            ? []
            : List<Brand>.from(json["groups"]!.map((x) => Brand.fromJson(x))),
        optionsValues: json["options_values"] == null
            ? []
            : List<OptionsValue>.from(
                json["options_values"]!.map((x) => OptionsValue.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ar_name": arName,
        "en_name": enName,
        "status": status,
        "branch_availability": branchAvailability,
        "ar_description": arDescription,
        "en_description": enDescription,
        "thumbnail": thumbnail,
        "video_provider": videoProvider,
        "video_link": videoLink,
        "price": price,
        "discount_start":
            "${discountStart!.year.toString().padLeft(4, '0')}-${discountStart!.month.toString().padLeft(2, '0')}-${discountStart!.day.toString().padLeft(2, '0')}",
        "discount_end":
            "${discountEnd!.year.toString().padLeft(4, '0')}-${discountEnd!.month.toString().padLeft(2, '0')}-${discountEnd!.day.toString().padLeft(2, '0')}",
        "discount": discount,
        "discount_type": discountType,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "category": category?.toJson(),
        "brand": brand?.toJson(),
        "occasions": occasions == null
            ? []
            : List<dynamic>.from(occasions!.map((x) => x.toJson())),
        "groups": groups == null
            ? []
            : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "options_values": optionsValues == null
            ? []
            : List<dynamic>.from(optionsValues!.map((x) => x.toJson())),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Brand {
  Brand({
    this.id,
    this.arName,
    this.enName,
  });

  int? id;
  String? arName;
  String? enName;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        arName: json["ar_name"],
        enName: json["en_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ar_name": arName,
        "en_name": enName,
      };
}

class Image {
  Image({
    this.id,
    this.path,
  });

  int? id;
  String? path;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
      };
}

class OptionsValue {
  OptionsValue({
    this.id,
    this.arName,
    this.enName,
    this.price,
    this.option,
  });

  int? id;
  String? arName;
  String? enName;
  String? price;
  Brand? option;

  factory OptionsValue.fromJson(Map<String, dynamic> json) => OptionsValue(
        id: json["id"],
        arName: json["ar_name"],
        enName: json["en_name"],
        price: json["price"],
        option: json["option"] == null ? null : Brand.fromJson(json["option"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ar_name": arName,
        "en_name": enName,
        "price": price,
        "option": option?.toJson(),
      };
}

class Paginate {
  Paginate({
    this.total,
    this.count,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
    this.currentPage,
    this.totalPages,
  });

  int? total;
  int? count;
  int? perPage;
  String? nextPageUrl;
  String? prevPageUrl;
  int? currentPage;
  int? totalPages;

  factory Paginate.fromJson(Map<String?, dynamic> json) => Paginate(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String?, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}
