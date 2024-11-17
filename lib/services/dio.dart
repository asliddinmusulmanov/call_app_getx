import 'package:call_app_getx/home/view_model/home_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class NetworkService {
  static Dio dio = Dio();

  static List<ContactsModel> contactsModelList = [];

  static const String contactsApi = "https://65c4be6adae2304e92e33e36.mockapi.io/user/products";
  static Future<void> getContacts() async {
    try {
      final result = await dio.get(contactsApi);

      if (result.statusCode == 200 || result.statusCode == 201) {
        // Assuming the response data is a list of contacts
        contactsModelList = (result.data as List).map((e) => ContactsModel.fromJson(e)).toList();
        debugPrint(contactsModelList.toString());
      }
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

  static Future<void> postContacts(ContactsModel data) async {
    final natija = await dio.post(contactsApi, data: data.toJson());
  }

  static Future<void> deleteContacts(String id) async {
    final natija1 = await dio.delete(
      "$contactsApi/$id",
    );
  }

  static Future<void> updateContacts(ContactsModel data, String id) async {
    final natija2 = await dio.put("$contactsApi/$id", data: data.toJson());
    try {
      if (natija2.statusCode == 200 || natija2.statusCode == 201) {
        // Assuming the response data is a list of contacts
        debugPrint(natija2.statusCode.toString());
      }
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }
}
