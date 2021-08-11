import 'package:flutter/material.dart';
//import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class About extends StatelessWidget {
  final String aboutImageUrl;
  final String aboutHotelname;
  final String aboutHoteldescription;
  final String wereda;
  final String state;
  final String city;
  final String email;
  final int phoneNo;
  const About(
      {Key? key,
      required this.aboutHoteldescription,
      required this.aboutHotelname,
      required this.city,
      required this.wereda,
      required this.state,
      required this.email,
      required this.phoneNo,
      required this.aboutImageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(
                  'https://www.casy.ch/wp-content/uploads/2021/01/hotel-agencies-2.jpg'), //jfslkadbvskvj
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                border: Border.all(
                    color: Colors.black, style: BorderStyle.solid, width: 2.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aboutHotelname,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    wereda + ', ' + city + ', ' + state + ', ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(Icons.call, color: Colors.black),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    phoneNo.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              indent: 4,
              endIndent: 4,
              thickness: 2,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Description",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  aboutHoteldescription,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
