import 'package:flutter/material.dart';
import 'package:form/new_pages/About.dart';
import 'package:form/pages/room_type.dart';
import 'dart:convert';
import 'package:form/new_pages/room_type_about.dart';
import 'package:form/pages/room_type_rooms.dart';

class RoomsTabView extends StatelessWidget {
  final String aboutImageUrl;
  final hotelId;
  final String token;
  final roomId;
  final price;
  final String aboutHoteldescription;
  final rating;
  final floorNo;
  final roomNo;
  final roomTypeName;
  final int roomtypeindex;
  final serviceName;

  final int count;

  const RoomsTabView(
      {Key? key,
      required this.aboutHoteldescription,
      required this.price,
      required this.roomNo,
      required this.rating,
      required this.floorNo,
      required this.token,
      this.serviceName,
      this.hotelId,
      this.roomId,
      this.roomTypeName,
      required this.aboutImageUrl,
      required this.roomtypeindex,
      required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Details',
              ),
              Tab(
                text: 'Rooms',
              ),
            ],
          ),
          title: Text(roomTypeName),
        ),
        body: TabBarView(
          children: [
            RoomtypeAbout(
                aboutHoteldescription: aboutHoteldescription,
                aboutImageUrl: aboutImageUrl,
                price: price,
                roomTypeindex: roomtypeindex,
                rating: rating),
            Rooms(
              roomscount: count,
              token: token,
              floorNo: floorNo,
              roomNo: roomNo,
              hotelId: hotelId,
              roomIdd: roomId,
              serviceName: serviceName,
            ),
          ],
        ),
      ),
    );
  }
}
