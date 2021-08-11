// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// class MyApp extends StatefulWidget {
//   final String token;
//   const MyApp({Key? key,required this.token}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String mutation = """
//   mutation(\$File:Upload){
//     hotelImageUpload(file:\$File){
//         imageURL
//         Id
//         createdAt
//         updatedAt
//         }
//     }""";
//   File? _image;
//   selectImage() async {
//     final ImagePicker _picker = ImagePicker();
//     var image = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = File(image!.path);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//      HttpLink httpLink = HttpLink(
//       'http://192.168.1.10:5000/',
//       defaultHeaders: <String, String>{
//         'Authorization': 'Bearer $token',
//       },
//     );
//     ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
//       link: httpLink,
//       cache: GraphQLCache(store: InMemoryStore()),
//     ));
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       body: Container(
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             if (_image != null)
//               Flexible(
//                 flex: 9,
//                 child: Image.file(_image!),
//               )
//             else
//               Flexible(
//                 flex: 9,
//                 child: Center(
//                   child: Text("No Image Selected"),
//                 ),
//               ),
//             Flexible(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   TextButton(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Icon(Icons.photo_library),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text("Select File"),
//                       ],
//                     ),
//                     onPressed: () => selectImage(),
//                   ),

//                   //ignore: unnecessary_null_comparison
//                   if (_image != null)
//                     Mutation(
//                       options: MutationOptions(
//                         document: gql(mutation),
//                         update: (GraphQLDataProxy cache, QueryResult? result) {
//                           return cache;
//                         },
//                         onCompleted: (dynamic resultData) {
//                           print('finished gg');
//                         },
//                       ),
//                       builder: (RunMutation runMutation, QueryResult? result) {
//                         return TextButton(
//                             onPressed: () {
//                               runMutation({'File': _image});
//                             },
//                             child: Text('upload'));
//                       },
//                     )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
