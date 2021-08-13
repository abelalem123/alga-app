import 'package:flutter/material.dart';
import 'package:form/new_pages/login_page - Copy.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'pages/home_view.dart';
import 'pages/floatingsearch bar.dart';
import 'package:get/get.dart';

import 'pages/ssample.dart';

//import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'http://192.168.1.17:5000/graphql',
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: GetMaterialApp(
            title: 'Registration Form',
            debugShowCheckedModeBanner: false,
            home: LoginPage()),
      ),
    );
  }
}

class SearchBarclass extends StatelessWidget {
  const SearchBarclass({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        FloatingSearchbar()
      ]),
    );
  }
}
