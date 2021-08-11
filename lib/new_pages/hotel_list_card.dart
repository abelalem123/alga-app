import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'About.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:nearby_hotel_detction_booking_app/Pages/Hotel_page.dart';
// import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class HotelListCart extends StatelessWidget {
  final String hotelImageurl;
  final String hotelName;
  //String hotel_rating_value;

  const HotelListCart(
      {Key? key, required this.hotelImageurl, required this.hotelName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var icon1 = Icon(
      Icons.favorite_outline_rounded,
      size: 30,
      color: Colors.black,
    );
    var icon2 = Icon(Icons.favorite, size: 30, color: Colors.red);
    var icon = icon1;
    return InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2.5),
              color: Color(0xFFF6F7FF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: ListTile(
            leading: Image.network(hotelImageurl),
            title: Text(
              hotelName,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 22),
            ),
            subtitle: RatingBarIndicator(
              rating: 2.75,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 40.0,
              direction: Axis.horizontal,
            ),
            // subtitle: RatingBar.builder(
            //   itemSize: 32,
            //   initialRating: 3,
            //   minRating: 1,
            //   direction: Axis.horizontal,
            //   allowHalfRating: true,
            //   itemCount: 5,
            //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            //   itemBuilder: (context, _) => Icon(
            //     Icons.star,
            //     color: Colors.amber,
            //   ),
            //   onRatingUpdate: (rating) {
            //     print(rating);
            //   },
            // ),
            trailing: IconButton(
                onPressed: () {
                  icon = icon2;
                },
                icon: icon),
          ),
        ));
  }
}
