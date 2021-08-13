import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_verification_box/verification_box.dart';
import 'package:form/pages/ssample.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ConfirmCode extends StatelessWidget {
  String mutation = """
  mutation(\$registrationCode: String){
registration(code: \$registrationCode) {
  createdAt
  email
  token
  firstName
  middleName
  lastName
  phone_no
  }
}
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Mutation(
            options: MutationOptions(
              document: gql(mutation),
              update: (GraphQLDataProxy cache, QueryResult? result) {
                return cache;
              },
              onCompleted: (dynamic resultData) {
                print('finished otp');
                Navigator.pop(context);
              },
            ),
            builder: (
              RunMutation runMutation,
              QueryResult? result,
            ) {
              return Container(
                margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("Enter Your Confirmation Code"),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 45,
                        child: VerificationBox(
                          count: 4,
                          borderColor: Colors.deepPurpleAccent,
                          borderWidth: 3,
                          borderRadius: 50,
                          type: VerificationBoxItemType.underline,
                          textStyle: TextStyle(color: Colors.black87),
                          showCursor: true,
                          cursorWidth: 2,
                          cursorColor: Colors.red,
                          cursorIndent: 10,
                          cursorEndIndent: 10,
                          focusBorderColor: Colors.deepPurpleAccent,
                          onSubmitted: (value) {
                            String token =
                                result!.data?['registration']['token'];
                            Get.to(Sample(token: token));
                            runMutation({'registrationCode': value.toString()});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
