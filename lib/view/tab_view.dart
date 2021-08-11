import 'package:flutter/material.dart';
import 'package:form/new_pages/About.dart';
import 'package:form/pages/room_type.dart';
import 'dart:convert';

class TabView extends StatelessWidget {
  final String aboutImageUrl;
  final String aboutHotelname;
  final String aboutHoteldescription;
  final String wereda;
  final String state;
  final String city;
  final String token;
  final String email;
  final int phoneNo;
  final id;
  final String hotelImageurl;
  final hotelName;
  final int roomTypescount;
  const TabView(
      {Key? key,
      required this.token,
      required this.aboutHoteldescription,
      required this.aboutHotelname,
      required this.city,
      this.id,
      required this.wereda,
      required this.state,
      required this.email,
      required this.phoneNo,
      required this.aboutImageUrl,
      required this.hotelImageurl,
      required this.roomTypescount,
      required this.hotelName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'About',
              ),
              Tab(
                text: 'Rooms',
              ),
              Tab(
                text: "Gallery",
              ),
            ],
          ),
          title: Text(aboutHotelname),
        ),
        body: TabBarView(
          children: [
            About(
                aboutHoteldescription: aboutHoteldescription,
                aboutHotelname: aboutHotelname,
                city: city,
                wereda: wereda,
                state: state,
                email: email,
                phoneNo: phoneNo,
                aboutImageUrl: aboutImageUrl),
            RoomType(
              hotelImageurl: hotelImageurl,
              hotelName: hotelName,
              roomTypescount: roomTypescount,
              token: token,
            ),
            Image.network(
              'https://www.casy.ch/wp-content/uploads/2021/01/hotel-agencies-2.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
