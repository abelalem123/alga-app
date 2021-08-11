// To parse this JSON data, do
//
//     final viewHotelsModel = viewHotelsModelFromJson(jsonString);

import 'dart:convert';

ViewHotelsModel viewHotelsModelFromJson(String str) =>
    ViewHotelsModel.fromJson(json.decode(str));

String viewHotelsModelToJson(ViewHotelsModel data) =>
    json.encode(data.toJson());

class ViewHotelsModel {
  ViewHotelsModel({
    required this.data,
  });

  Data data;

  factory ViewHotelsModel.fromJson(Map<String, dynamic> json) =>
      ViewHotelsModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.viewHotels,
  });

  List<ViewHotel> viewHotels;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        viewHotels: List<ViewHotel>.from(
            json["viewHotels"].map((x) => ViewHotel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "viewHotels": List<dynamic>.from(viewHotels.map((x) => x.toJson())),
      };
}

class ViewHotel {
  ViewHotel({
    required this.id,
    required this.description,
    required this.type,
    required this.name,
    required this.email,
    required this.phoneNo,
    this.sellers,
    required this.services,
    required this.rate,
    required this.updatedAt,
    required this.createdAt,
    required this.photos,
    required this.roomTypes,
    required this.comments,
    required this.location,
  });

  String id;
  String description;
  String type;
  String name;
  String email;
  int phoneNo;
  dynamic sellers;
  List<dynamic> services;
  Rate rate;
  DateTime updatedAt;
  DateTime createdAt;
  List<dynamic> photos;
  List<dynamic> roomTypes;
  List<Comment> comments;
  Location location;

  factory ViewHotel.fromJson(Map<String, dynamic> json) => ViewHotel(
        id: json["Id"],
        description: json["description"],
        type: json["type"],
        name: json["name"],
        email: json["email"],
        phoneNo: json["phone_no"],
        sellers: json["sellers"],
        services: List<dynamic>.from(json["services"].map((x) => x)),
        rate: Rate.fromJson(json["rate"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        photos: List<dynamic>.from(json["photos"].map((x) => x)),
        roomTypes: List<dynamic>.from(json["roomTypes"].map((x) => x)),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "description": description,
        "type": type,
        "name": name,
        "email": email,
        "phone_no": phoneNo,
        "sellers": sellers,
        "services": List<dynamic>.from(services.map((x) => x)),
        "rate": rate.toJson(),
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "roomTypes": List<dynamic>.from(roomTypes.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "location": location.toJson(),
      };
}

class Comment {
  Comment({
    required this.id,
    required this.body,
    this.user,
  });

  String id;
  String body;
  dynamic user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["Id"],
        body: json["body"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "body": body,
        "user": user,
      };
}

class Location {
  Location({
    required this.id,
    required this.city,
    required this.wereda,
    required this.state,
  });

  String id;
  String city;
  String wereda;
  String state;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["Id"],
        city: json["city"],
        wereda: json["wereda"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "city": city,
        "wereda": wereda,
        "state": state,
      };
}

class Rate {
  Rate({
    this.id,
    this.rateTotal,
    this.rateCount,
    required this.rateAvarage,
  });

  dynamic id;
  dynamic rateTotal;
  dynamic rateCount;
  int rateAvarage;

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        id: json["Id"],
        rateTotal: json["rateTotal"],
        rateCount: json["rateCount"],
        rateAvarage: json["rateAvarage"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "rateTotal": rateTotal,
        "rateCount": rateCount,
        "rateAvarage": rateAvarage,
      };
}
