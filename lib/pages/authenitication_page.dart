import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'home_page.dart';

class AuthPage extends StatelessWidget {
  final String usernameHolder;
  final String passwordHolder;

  const AuthPage(
      {Key? key, required this.usernameHolder, required this.passwordHolder})
      : super(key: key);
  final String query = """
 query(\$loginPassword: String, \$loginUsername: String){
  login(password: \$loginPassword,username: \$loginUsername) {
   
  token
  }
}
""";

  @override
  Widget build(BuildContext context) {
    String token = '';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Query(
            options: QueryOptions(document: gql(query), variables: {
              'loginPassword': passwordHolder,
              'loginUsername': usernameHolder
            }),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                return Text('Invalid Username or Password');
              }

              if (result.isLoading) {
                return CircularProgressIndicator();
              }

              if (result != null) {
                token = result.data as String;
              }
              return Column(
                children: [
                  Text(result.data != null ? '' : 'there is error'),
                  MaterialButton(
                    onPressed: () {
                      if (result.data != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      token: token,
                                    )));
                      }
                    },
                    child: Text('Press'),
                  )
                ],
              );
            }),
      ),
    );
  }
}
