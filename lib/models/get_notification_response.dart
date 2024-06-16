// To parse this JSON data, do
//
//     final getNotificationResponse = getNotificationResponseFromJson(jsonString);

import 'dart:convert';

GetNotificationResponse getNotificationResponseFromJson(String str) => GetNotificationResponse.fromJson(json.decode(str));

String getNotificationResponseToJson(GetNotificationResponse data) => json.encode(data.toJson());

class GetNotificationResponse {
    String? status;
    String? message;
    List<Notif>? data;

    GetNotificationResponse({
        this.status,
        this.message,
        this.data,
    });

    factory GetNotificationResponse.fromJson(Map<String, dynamic> json) => GetNotificationResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Notif>.from(json["data"]!.map((x) => Notif.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Notif {
    int? id;
    String? title;
    String? body;
    int? userId;
    bool? isRead;
    DateTime? createdAt;

    Notif({
        this.id,
        this.title,
        this.body,
        this.userId,
        this.isRead,
        this.createdAt,
    });

    factory Notif.fromJson(Map<String, dynamic> json) => Notif(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        userId: json["user_id"],
        isRead: json["is_read"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "user_id": userId,
        "is_read": isRead,
        "created_at": createdAt?.toIso8601String(),
    };
}



