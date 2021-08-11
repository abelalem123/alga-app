import 'package:flutter/material.dart';
import 'package:form/new_pages/hotel_list_card.dart';
import 'package:form/pages/booking_page.dart';

class Rooms extends StatelessWidget {
  final floorNo;
  final roomNo;
  final int roomscount;
  final serviceName;
  final hotelId;
  final roomIdd;
  final String token;
  const Rooms(
      {Key? key,
      required this.roomscount,
      required this.floorNo,
      this.hotelId,
      required this.token,
      this.roomIdd,
      this.serviceName,
      required this.roomNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: roomscount,
          itemBuilder: (context, index) {
            return InkWell(
              onLongPress: () {
                print(roomIdd[index]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingPage(
                              token: token,
                              serviceName: serviceName,
                              hotelId: hotelId,
                              roomId: roomIdd[index],
                            )));
              },
              child: ListTile(
                leading: Text(floorNo[index].toString()),
                title: Text(roomNo[index]),
              ),
            );
          }),
    );
  }
}
