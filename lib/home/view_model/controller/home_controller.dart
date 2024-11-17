import 'package:call_app_getx/home/view_model/home_model.dart';
import 'package:call_app_getx/services/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  HomeController() {
    getData();
  }
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  final storage = GetStorage();

  RxList<ContactsModel> postList = <ContactsModel>[].obs;

  void getData() async {
    await NetworkService.getContacts();
    postList.value = NetworkService.contactsModelList;
    storage.write('data', NetworkService.contactsModelList);
    debugPrint('STORGE :${storage.read('data') ?? 'no data'}');
  }

  void postData(ContactsModel data) async {
    await NetworkService.postContacts(data);
    postList.value = NetworkService.contactsModelList;
    getData();
  }

  void deleteData(String id) async {
    await NetworkService.deleteContacts(id);
    postList.value = NetworkService.contactsModelList;
    getData();
  }

  void updateData(ContactsModel data, String? id) async {
    await NetworkService.updateContacts(data, id!);
    postList.value = NetworkService.contactsModelList;
    getData();
  }
}
