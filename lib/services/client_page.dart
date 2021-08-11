import 'dart:convert';

import 'package:form/model/viewHotels.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

String x = """
query{
  viewHotels{
    Id
    description
    type
    name
    email
    phone_no
    sellers {
      Id
      firstName
      lastName
      middleName
      phone_no
      password
      username
      updatedAt
      createdAt
    }
    services {
      Id
      name
      description
      updatedAt
      createdAt
    }
    rate {
      Id
      rateTotal
      rateCount
      rateAvarage
    }
    updatedAt
    createdAt
    photos {
      Id
      imageURI
      createdAt
      updatedAt
    }
    roomTypes {
      Id
      description
      name
      createdAt
      updatedAt
      rooms {
        Id
        floor_no
        room_no
        updatedAt
        createdAt
        available
      }
      images {
        Id
        imageURI
        createdAt
        updatedAt
      }
      roomService {
        Id
        name
        description
        price
        createdAt
        updatedAt
      }
      capacity
      price
      rate {
        Id
        rateTotal
        rateCount
        rateAvarage
      }
    }
    comments {
      Id
      body
      user {
        Id
        firstName
        lastName
        middleName
        email
        phone_no
      }
    }
    location {
      Id
      city
      wereda
      state
    }
  }
}
""";

class ClientPage {
  var client = http.Client;
  Future<ViewHotelsModel> fetchHotels() async {
    var uri =
        Uri.parse('http://192.168.1.17:5000/graphql?query={viewHotels{name}}');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return ViewHotelsModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Hotel');
    }
  }
}
