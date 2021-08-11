import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final String token;

  HomePage({Key? key, required this.token}) : super(key: key);
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController codeController = TextEditingController();
  var email = '';
  var password = '';
  var code = '';

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  String? validatecode(String value) {
    if (value.length > 4) {
      return "code must be 4 digit";
    }
    return null;
  }

  String mutation1 = """
  mutation(\$preUserChangePasswordEmail: String){
  preUserChangePassword(email: \$preUserChangePasswordEmail) {
    message
  }
}
  """;
  String mutation2 = """
  mutation(\$userChangePasswordCode: String, \$userChangePasswordPassword: String){
 userChangePassword(code: \$userChangePasswordCode,password: \$userChangePasswordPassword) {
   message
 }
}
  """;
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    HttpLink httpLink = HttpLink(
      'http://192.168.1.10:5000/graphql',
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
            title: Text('Home Page'),
            backgroundColor: Colors.deepPurpleAccent,
          ),
          body: Center(
              child: Column(
            children: [
              Mutation(
                options: MutationOptions(
                  document: gql(mutation1),
                  update: (GraphQLDataProxy cache, QueryResult? result) {
                    return cache;
                  },
                  onCompleted: (dynamic resultData) {
                    print('finished g1');
                    codeSent = true;
                  },
                ),
                builder: (
                  RunMutation runMutation,
                  QueryResult? result,
                ) {
                  return Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Email",
                          helperText: 'Enter Your Email Here',
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (value) {
                          email = value!;
                        },
                        validator: (value) {
                          return validateEmail(value!);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            runMutation({
                              'preUserChangePasswordEmail':
                                  emailController.text,
                            });
                          },
                          child: Text('Submit')),
                    ],
                  );
                },
              ),
              if (codeSent = true)
                Mutation(
                    options: MutationOptions(
                      document: gql(mutation2),
                      update: (GraphQLDataProxy cache, QueryResult? result) {
                        return cache;
                      },
                      onCompleted: (dynamic resultData) {
                        print('finished g2');
                      },
                    ),
                    builder: (
                      RunMutation runMutation,
                      QueryResult? result,
                    ) {
                      return Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Code",
                              helperText: 'Enter the code here',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            maxLength: 4,
                            controller: codeController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (value) {
                              code = value!;
                            },
                            validator: (value) {
                              return validatecode(value!);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Password",
                              helperText: 'Enter the new password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            controller: passwordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (value) {
                              password = value!;
                            },
                            validator: (value) {
                              return validatePassword(value!);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextButton(
                              child: Text('Change Password'),
                              onPressed: () {
                                runMutation({
                                  'userChangePasswordCode': codeController.text,
                                  'userChangePasswordPassword':
                                      passwordController.text,
                                });
                              })
                        ],
                      );
                    })
            ],
          ))),
    );
  }
}
