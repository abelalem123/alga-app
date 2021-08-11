import 'package:flutter/cupertino.dart';
import 'package:form/controller/viewHotelController.dart';
import 'package:form/new_pages/About.dart';
import 'package:form/new_pages/hotel_list_card.dart';
import 'package:form/view/tab_view.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form/model/real_model.dart';

// ignore: must_be_immutable
class Sample extends StatelessWidget {
  String token;
  Sample({Key? key, required this.token}) : super(key: key);

  final ViewHotelController viewHotelController =
      Get.put(ViewHotelController());
  String query = """
  query{
  viewHotels{
    Id
    description
    type
    name
    email
    phone_no
    sellers {
      Id
      firstName
      lastName
      middleName
      phone_no
      password
      username
      updatedAt
      createdAt
    }
    services {
      Id
      name
      description
      updatedAt
      createdAt
    }
    rate {
      Id
      rateTotal
      rateCount
      rateAvarage
    }
    updatedAt
    createdAt
    photos {
      Id
      imageURI
      createdAt
      updatedAt
    }
    roomTypes {
      Id
      description
      name
      createdAt
      updatedAt
      rooms {
        Id
        floor_no
        room_no
        updatedAt
        createdAt
        available
      }
      images {
        Id
        imageURI
        createdAt
        updatedAt
      }
      roomService {
        Id
        name
        description
        price
        createdAt
        updatedAt
      }
      capacity
      price
      rate {
        Id
        rateTotal
        rateCount
        rateAvarage
      }
    }
    comments {
      Id
      body
      user {
        Id
        firstName
        lastName
        middleName
        email
        phone_no
      }
    }
    location {
      Id
      city
      wereda
      state
    }
  }
}
  """;
  String? _currentId;

  //late List<Hotel> hotels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
          options: QueryOptions(
            document: gql(query),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              print("loading");
              return Center(child: CircularProgressIndicator());
            }

            // for (int index = 0; index < 5; index++) {
            //   Hotel hotel = Hotel(
            //     name: result.data?['viewHotels'][index]['name'],
            //     description: result.data?['viewHotels'][index]['description'],
            //     id: result.data?['viewHotels'][index]['Id'],
            //     email: result.data?['viewHotels'][index]['email'],
            //     phoneNo: 09,
            //   );
            //   // hotels.add(hotel);
            // }
            return ListView.builder(
                itemCount: result.data?['viewHotels'].length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () {
                      _currentId = result.data?['viewHotels'][index]['Id'];
                      List<String> hotels = [];
                      int y =
                          result.data?['viewHotels'][index]['roomTypes'].length;
                      String name = '';

                      for (int z = 0; z < y; z++) {
                        name = result.data?['viewHotels'][index]['roomTypes'][z]
                            ['name'];
                        hotels.add(name);
                      }

                      print(index);

                      print(_currentId);
                      print(hotels);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TabView(
                                    aboutHoteldescription:
                                        result.data?['viewHotels'][index]
                                            ['description'],
                                    aboutHotelname: result.data?['viewHotels']
                                        [index]['name'],
                                    city: result.data?['viewHotels'][index]
                                        ['location']['city'],
                                    wereda: result.data?['viewHotels'][index]
                                        ['location']['wereda'],
                                    state: result.data?['viewHotels'][index]
                                        ['location']['state'],
                                    email: result.data?['viewHotels'][index]
                                        ['email'],
                                    phoneNo: result.data?['viewHotels'][index]
                                        ['phone_no'],
                                    aboutImageUrl: '',
                                    roomTypescount: index,
                                    token: token,
                                    hotelName: hotels,
                                    id: result.data?['viewHotels'][index]['Id'],
                                    hotelImageurl:
                                        'https://media.istockphoto.com/photos/3d-rendering-beautiful-luxury-bedroom-suite-in-hotel-with-tv-picture-id1066999762?k=6&m=1066999762&s=612x612&w=0&h=SQ2803yCqKwHiSrqJPVOU-DJwaYswbI2wDq3Z-dV5DA=',
                                  )));
                    },
                    child: HotelListCart(
                        hotelImageurl:
                            'https://www.casy.ch/wp-content/uploads/2021/01/hotel-agencies-2.jpg',
                        hotelName: result.data?['viewHotels'][index]['name']),
                  );
                });
          }),
    );
  }
}
