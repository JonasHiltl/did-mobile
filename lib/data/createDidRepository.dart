import 'dart:convert';
import 'package:dio/dio.dart';

import "../models/did.dart";

class CreateDidRepository {
  Dio dio = Dio();
  Future<Did> createDid(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      DateTime? dateOfBirth,
      String sex,
      String address,
      String city,
      String state,
      String postalCode,
      String country) async {
    final res = await dio.post("http://did-backend.herokuapp.com/create",
        data: {
          "firstName": firstName.trim(),
          "lastName": lastName.trim(),
          "email": email.trim(),
          "phoneNumber": phoneNumber.trim(),
          "dateOfBirth": dateOfBirth?.toIso8601String(),
          "sex": sex.trim(),
          "address": address.trim(),
          "city": city.trim(),
          "state": state.trim(),
          "postalCode": postalCode.trim(),
          "country": country.trim()
        },
        options: Options(headers: {
          Headers.contentTypeHeader: "application/json",
        }));
    if (res.statusCode == 200) {
      final json = jsonDecode(res.toString()) as Map<String, dynamic>;
      return Did.fromJson(json);
    }
    throw "Identity request failed";
  }
}
