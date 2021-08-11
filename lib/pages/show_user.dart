import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({Key? key}) : super(key: key);

  @override
  _ShowUserState createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  final String query = """
  query MyQuery {
  User {
    email
    id
    name
  }
}
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("show user"),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(query),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (result.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: result.data?['user'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(result.data?['user'][index]['name']),
                      subtitle: Text(result.data?['user'][index]['email']));
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {},
      ),
    );
  }
}
