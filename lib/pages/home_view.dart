import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'conf_code.dart';
import 'controller.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:get/get.dart';
import 'login_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      nameController = TextEditingController(),
      firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      middleNameController = TextEditingController(),
      phoneNocontroller = TextEditingController(),
      confirmPasswordController = TextEditingController();
  var email = '';
  var password = '';
  var name = '';
  var phoneNo = '';
  var confPass = '';
  var firstName = '';
  var lastName = '';
  var middleName = '';

  // emailController
  //   passwordController
  //   nameController
  //   phoneNocontroller
  //   confirmPasswordController
  //   firstNameController
  //   lastNameController = TextEditingController();
  //   middleNameController

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
  String mutation = """
  mutation (\$firstName:String,\$lastName:String,\$middleName:String,\$phone_no:Int,\$email:String,\$password:String,\$nationality:String){
  preRegister(userInfo:{firstName:\$firstName,lastName:\$lastName,middleName:\$middleName,phone_no:\$phone_no,email:\$email,password:\$password,nationality:\$nationality}) {
    message
  }
}
  """
      .replaceAll('\n', '');
  String nationality = 'Ethiopian';
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
                print('finished gg');
              },
            ),
            builder: (
              RunMutation runMutation,
              QueryResult? result,
            ) {
              return SafeArea(
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                  width: context.width,
                  height: context.height,
                  child: SingleChildScrollView(
                    child: Form(
                      key: loginFormKey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: Column(children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "First Name",
                              prefixIcon: Icon(Icons.person),
                            ),
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              new FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z]")),
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: firstNameController,
                            onSaved: (value) {
                              firstName = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter First name';
                              }
                              return null;
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
                              labelText: "Middle Name",
                              prefixIcon: Icon(Icons.person),
                            ),
                            keyboardType: TextInputType.text,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              new FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z]")),
                            ],
                            controller: middleNameController,
                            onSaved: (value) {
                              middleName = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Middle name';
                              }
                              return null;
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
                              labelText: "Last Name",
                              prefixIcon: Icon(Icons.person),
                            ),
                            keyboardType: TextInputType.text,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              new FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z]")),
                            ],
                            controller: lastNameController,
                            onSaved: (value) {
                              lastName = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Last name';
                              }
                              return null;
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
                          SizedBox(
                            height: 16,
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
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Confirm Password",
                              prefixIcon: Icon(Icons.lock),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            controller: confirmPasswordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (value) {
                              confPass = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {}
                              // return null;

                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                return "Password does not match";
                              }
                              return null;
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
                              labelText: "Phone Number",
                              prefixIcon: Icon(Icons.phone),
                            ),
                            keyboardType: TextInputType.phone,
                            controller: phoneNocontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            maxLength: 10,
                            inputFormatters: [
                              new FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                            ],
                            onSaved: (value) {
                              phoneNo = value!;
                            },
                            validator: (value) {
                              return validatePhoneNo(value!);
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: context.width),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurpleAccent),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(14)),
                              ),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              onPressed: () {
                                bool x = checkLogin();
                                if (x) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfirmCode()),
                                  );
                                }
                                runMutation({
                                  'email': emailController.text,
                                  'firstName': firstNameController.text,
                                  'middleName': middleNameController.text,
                                  'lastName': lastNameController.text,
                                  'password': passwordController.text,
                                  'nationality': nationality,
                                  'phone_no': int.parse(phoneNocontroller.text)
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text(
                                "Already Have an Account?",
                                style:
                                    TextStyle(color: Colors.deepPurpleAccent),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                      ),
                      // ignore: dead_code
                    ),
                  ),
                ),
              );
            }));
  }
}
