import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:form/new_pages/temp.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:string_validator/string_validator.dart';

import 'package:form/pages/ssample.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var email = '';

  var password = '';
  var username = '';

  final String query = """
 query(\$loginPassword: String, \$loginUsername: String){
  login(password: \$loginPassword,username: \$loginUsername) {
   
  token
  }
}
""";

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePhoneNo(String value) {
    if (!GetUtils.isPhoneNumber(value)) {
      return "Provide valid Phone Number";
    }
    return null;
  }

  String mutation = """
  mutation(\$forgetPasswordEmail: String){
  forgetPassword(email: \$forgetPasswordEmail) {
    message
  }
}
  """;

  String? validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  bool checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      loginFormKey.currentState!.save();
      return true;
    }
  }

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'http://192.168.1.17:5000/graphql',
    );
    String token = '';
    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));
    return GraphQLProvider(
      client: client,
      child: Scaffold(
          body: SafeArea(
              child: Form(
        key: loginFormKey,
        child: Column(children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "User Name",
              helperText: 'Email or Password',
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            controller: usernameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onSaved: (value) {
              username = value!;
            },
            validator: (value) {
              return validatePhoneNo(usernameController.text);
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
              prefixIcon: Icon(Icons.lock),
            ),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            controller: passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all(Colors.deepPurpleAccent),
                padding: MaterialStateProperty.all(EdgeInsets.all(14)),
              ),
              child: Text(
                "Log in",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              onPressed: () {
                bool x = checkLogin();
                if (x) {
                  Query(
                      options: QueryOptions(document: gql(query), variables: {
                        'loginPassword': passwordController.text,
                        'loginUsername': usernameController.text
                      }),
                      builder: (QueryResult result,
                          {VoidCallback? refetch, FetchMore? fetchMore}) {
                        if (result.hasException) {
                          Get.back();
                          return Text(result.exception.toString());
                        }

                        if (result.isLoading) {
                          return CircularProgressIndicator();
                        }

                        token = result.data?['login']['token'];
                        print(token);

                        return Temp(
                          token: token,
                        );
                      });
                } else {
                  checkLogin();
                }
              },
            ),
          ),
          TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Mutation(
                        options: MutationOptions(
                          document: gql(mutation),
                          update:
                              (GraphQLDataProxy cache, QueryResult? result) {
                            return cache;
                          },
                          onCompleted: (dynamic resultData) {
                            Navigator.pop(context);
                            print('ggc');
                          },
                        ),
                        builder: (
                          RunMutation runMutation,
                          QueryResult? result,
                        ) {
                          return Column(
                            children: [
                              Text("Enter Your Email Here"),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onSaved: (value) {
                                  email = value!;
                                },
                                validator: (value) {
                                  return validateEmail(value!);
                                },
                              ),
                              TextButton(
                                child: Text("Proceed"),
                                onPressed: () {
                                  if (result!.data == null)
                                    runMutation({
                                      'forgetPasswordEmail':
                                          emailController.text,
                                    });
                                },
                              )
                            ],
                          );
                        });
                  },
                );
              },
              child: Text("Forget Password?")),
        ]),
      ))),
    );
  }
}
