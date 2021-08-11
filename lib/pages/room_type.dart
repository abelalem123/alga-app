import 'package:flutter/material.dart';
import 'package:form/new_pages/hotel_list_card.dart';
import 'package:form/pages/room_type_rooms.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:form/view/rooms_tabView.dart';

class RoomType extends StatelessWidget {
  final String hotelImageurl;
  final hotelName;
  final String token;

  final int roomTypescount;
  const RoomType(
      {Key? key,
      required this.roomTypescount,
      required this.hotelImageurl,
      required this.token,
      required this.hotelName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      price
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
      createdAt
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
    String idd;

    String image =
        'https://media.istockphoto.com/photos/3d-rendering-beautiful-luxury-bedroom-suite-in-hotel-with-tv-picture-id1066999762?k=6&m=1066999762&s=612x612&w=0&h=SQ2803yCqKwHiSrqJPVOU-DJwaYswbI2wDq3Z-dV5DA=';
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
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
                itemCount: result
                    .data?['viewHotels'][roomTypescount]['roomTypes'].length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () {
                      //print(hotelName[index]);
                      List<String> roomNos = [];

                      List<int> floorNos = [];
                      List<String> serviceNames = [];
                      List<String> roomsId = [];

                      int roomsCount = result
                          .data?['viewHotels'][roomTypescount]['roomTypes']
                              [index]['rooms']
                          .length;
                      int roomservicesCount = result
                          .data?['viewHotels'][roomTypescount]['roomTypes']
                              [index]['roomService']
                          .length;
                      String room_no;
                      String id;

                      int floor_no;
                      String serviceName;

                      for (int z = 0; z < roomsCount; z++) {
                        room_no = result.data?['viewHotels'][roomTypescount]
                            ['roomTypes'][index]['rooms'][z]['room_no'];
                        roomNos.add(room_no);
                        floor_no = result.data?['viewHotels'][roomTypescount]
                            ['roomTypes'][index]['rooms'][z]['floor_no'];
                        floorNos.add(floor_no);
                        id = result.data?['viewHotels'][roomTypescount]
                            ['roomTypes'][index]['rooms'][z]['Id'];
                        roomsId.add(id);
                      }
                      for (int z = 0; z < roomservicesCount; z++) {
                        serviceName = result.data?['viewHotels'][roomTypescount]
                            ['roomTypes'][index]['roomService'][z]['name'];
                        serviceNames.add(serviceName);
                      }
                      idd = result.data?['viewHotels'][roomTypescount]['Id'];
                      print(roomsId);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RoomsTabView(
                                  token: token,
                                  roomTypeName: result.data?['viewHotels']
                                          [roomTypescount]['roomTypes'][index]
                                      ['name'],
                                  aboutHoteldescription:
                                      result.data?['viewHotels'][roomTypescount]
                                          ['roomTypes'][index]['description'],
                                  price: result.data?['viewHotels']
                                          [roomTypescount]['roomTypes'][index]
                                      ['price'],
                                  roomNo: roomNos,
                                  rating: 5,
                                  floorNo: floorNos,
                                  roomId: roomsId,
                                  hotelId: idd,
                                  aboutImageUrl: image,
                                  roomtypeindex: index,
                                  serviceName: serviceNames,
                                  count: roomsCount)));
                    },
                    child: HotelListCart(
                        hotelImageurl: image,
                        hotelName: result.data?['viewHotels'][roomTypescount]
                            ['roomTypes'][index]['name']),
                  );
                });
          }),
    );
  }
}
