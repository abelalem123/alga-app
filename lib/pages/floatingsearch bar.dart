import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FloatingSearchbar extends StatefulWidget {
  const FloatingSearchbar({Key? key}) : super(key: key);

  @override
  _FloatingSearchbarState createState() => _FloatingSearchbarState();
}

class _FloatingSearchbarState extends State<FloatingSearchbar> {
  final cities = [];

  final recentCities = ['cd', 'dvsv', 'dsvdv'];
  final String query = "";
  String query1 = """
    query{
  viewHotels{
    name
    }
    }
  """;
  List suggessionList = [];
  // List<int> items = List<int>.generate(10, (int index) => index);
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      hint: 'Search for Hotels...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        suggessionList = query.isEmpty
            ? recentCities
            : cities
                .where((p) => p.contains(
                      query,
                    ))
                .toList();
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      automaticallyImplyDrawerHamburger: false,
      automaticallyImplyBackButton: false,
      transition: CircularFloatingSearchBarTransition(),
      leadingActions: [
        Builder(
            builder: (con) => IconButton(
                  icon: Icon(CupertinoIcons.list_dash, color: Colors.blue),
                  onPressed: () => Scaffold.of(con).openDrawer(),
                )),
      ],

      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(
              Icons.search,
              color: Colors.blue,
            ),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      closeOnBackdropTap: true,

      builder: (context, transition) {
        return Query(
            options: QueryOptions(
              document: gql(query1),
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2.5),
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0))),
                //height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: result.data?['viewHotels'].length,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: (BuildContext context, int index) {
                    List<String> hotelnames = [];
                    int hotelsCount = result.data?['viewHotels'].length;

                    for (int x = 0; x < hotelsCount; x++) {
                      String hotelname = result.data?['viewHotels'][x]['name'];
                      hotelnames.add(hotelname);
                    }
                    print(hotelnames);

                    return InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          LoginPage(),
                          isDismissible: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                        );
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 1),
                          height: 80,
                          child: Text(hotelnames[index]),
                          color: Colors.white),
                    );
                  },
                ),
              );
            });
      },
    );
  }
}
