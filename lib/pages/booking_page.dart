import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:form/controller/booking_page_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatelessWidget {
  final serviceName;
  final hotelId;
  final roomId;
  final String token;
  BookingPage(
      {Key? key,
      this.serviceName,
      required this.token,
      this.hotelId,
      this.roomId});

  late DateTime? currentDatein = DateTime.now();
  late DateTime? currentDateout = currentDatein;

  Future<void> _selectDatein(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));

    bookingPageController.updateDateIn(pickedDate);
  }

  BookingPageController bookingPageController =
      Get.put(BookingPageController());

  Future<void> _selectDateout(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: bookingPageController.initialOut,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    bookingPageController.updateDateOut(pickedDate);
  }

  late TimeOfDay? currentTimein = TimeOfDay.now();
  late TimeOfDay? currentTimeout = currentTimein;

  Future<void> _selectTimein(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    bookingPageController.updateTimeIn(timeOfDay);
  }

  Future<void> _selectTimeout(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    bookingPageController.updateTimeout(timeOfDay);
  }

  String mutation = """
 mutation(\$checkin_time:String,\$checkout_time:String,\$roomId:ID,\$hotelId:ID){
  addReservation(reservationInfo:{checkin_time:\$checkin_time,checkout_time:\$checkout_time,roomId:\$roomId,hotelId:\$hotelId}) {
    checkin_time
  }
}
  """;
  late String checkin_time = bookingPageController.curentTimein.toString() +
      bookingPageController.currentDatein.toString();
  late String checkout_time = bookingPageController.currentTimeout.toString() +
      bookingPageController.currentDateout.toString();
  @override
  Widget build(BuildContext context) {
    HttpLink httpLink = HttpLink(
      'http://192.168.1.17:5000/graphql',
      defaultHeaders: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reservation Form'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Check in Date',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              _selectDatein(context);
                            },
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Check in Time',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              _selectTimein(context);
                            },
                            icon: Icon(
                              Icons.timer,
                              color: Colors.blue,
                            )),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: [
                        Text(
                          'Check out Date',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              _selectDateout(context);
                            },
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Check out Time',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              _selectTimeout(context);
                            },
                            icon: Icon(
                              Icons.timer,
                              color: Colors.blue,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Mutation(
                options: MutationOptions(
                  document: gql(mutation),
                  update: (GraphQLDataProxy cache, QueryResult? result) {
                    return cache;
                  },
                  onCompleted: (dynamic resultData) {
                    print('finished lgg');
                    //  print(token);
                  },
                ),
                builder: (
                  RunMutation runMutation,
                  QueryResult? result,
                ) {
                  return GetBuilder<BookingPageController>(builder: (_) {
                    return InkWell(
                        onLongPress: () {
                          print('sdsds');
                          runMutation({
                            'roomId': roomId,
                            'hotelId': hotelId,
                            'checkin_time': DateFormat('yyyy-MM-dd – kk:mm')
                                .format(bookingPageController.currentDatein!),
                            'checkout_time': DateFormat('yyyy-MM-dd – kk:mm')
                                .format(bookingPageController.currentDatein!)
                          });
                        },
                        child: Text('Reserve'));
                  });
                }),
            SizedBox(
              height: 30,
            ),
            GetBuilder<BookingPageController>(builder: (_) {
              return Expanded(
                flex: 1,
                child: Text(DateFormat('yyyy-MM-dd – kk:mm')
                    .format(bookingPageController.currentDatein!)),
              );
            }),
            // Expanded(
            //   flex: 6,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 60),
            //     child: ListView.builder(
            //         itemCount: serviceName.length,
            //         itemBuilder: (contex, index) {
            //           return ListTile(title: Text(serviceName[index]));
            //         }),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
