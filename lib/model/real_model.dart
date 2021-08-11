import 'dart:core';

class Hotel {
  String id;
  String description;
  String name;
  String email;
  int phoneNo;
  Hotel({
    required this.id,
    required this.description,
    required this.name,
    required this.email,
    required this.phoneNo,
  });
}

class HotelImage {
  String id;
  String imageURL;
  HotelImage({required this.id, required this.imageURL});
}

class Location {
  String id;
  String city;
  String wereda;
  String state;
  Location({
    required this.id,
    required this.city,
    required this.wereda,
    required this.state,
  });
}
