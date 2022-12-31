// To parse this JSON data, do
//
//     final allNotificationsModel = allNotificationsModelFromJson(jsonString);

import 'dart:convert';

enum NotificationType { couponNotify, contactUsNotify, adminReply }

AllNotificationsModel allNotificationsModelFromJson(String str) =>
    AllNotificationsModel.fromJson(json.decode(str));

String allNotificationsModelToJson(AllNotificationsModel data) =>
    json.encode(data.toJson());

class AllNotificationsModel {
  AllNotificationsModel({
    this.status = true,
    this.data = const [],
  });

  bool status;
  List<NotificationModel> data;

  factory AllNotificationsModel.fromJson(Map<String, dynamic> json) =>
      AllNotificationsModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<NotificationModel>.from(
                json["data"].map((x) => NotificationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NotificationModel {
  NotificationModel({
    this.title,
    this.notificationType = NotificationType.adminReply,
    this.enTitle,
    this.body,
    this.enBody,
    this.typeName,
    this.typeId,
    this.id,
    this.isRead = false,
    this.createdAt,
  });

  String? title;
  String? enTitle;
  String? body;
  NotificationType notificationType;
  String? enBody;
  String? typeName;
  int? typeId;
  int? id;
  bool isRead;
  String? createdAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    NotificationType type;

    switch (json["type_name"].toString()) {
      case 'coupon_notify':
        type = NotificationType.couponNotify;
        break;
      case 'admin_reply':
        type = NotificationType.adminReply;
        break;
      case 'contact_us':
        type = NotificationType.contactUsNotify;
        break;
      default:
        type = NotificationType.adminReply;
    }

    return NotificationModel(
      title: json["title"],
      enTitle: json["en_title"],
      body: json["body"],
      enBody: json["en_body"],
      notificationType: type,
      typeName: json["type_name"],
      typeId: json["type_id"],
      id: json["id"],
      isRead: json["is_read"].toString() == "1",
      createdAt: json["created_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "en_title": enTitle,
        "body": body,
        "en_body": enBody,
        "type_name": typeName,
        "type_id": typeId,
        "id": id,
        "is_read": isRead,
        "created_at": createdAt,
      };
}
