import 'package:call_app_getx/home/view_model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../view_model/controller/home_controller.dart';
import '../widgets/custom_dialog_widget.dart';

class HomePage extends StatelessWidget {
  final HomeController ctr = Get.find<HomeController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.grey.shade300,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Contacts",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          // Observe the contacts observable list here
          if (ctr.postList.isEmpty) {
            return const Center(child: Text('No contacts available'));
          }
          return ListView.builder(
            itemCount: ctr.postList.length,
            itemBuilder: (context, index) {
              final contact = ctr.postList[index];
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                      icon: Icons.edit,
                      label: "Edit",
                      onPressed: (value) {
                        final upDateName = TextEditingController(text: ctr.postList[index].name);
                        final upDateNumber = TextEditingController(text: ctr.postList[index].number);
                        showDialog(
                          context: context,
                          builder: (contex) {
                            return CustomDialogW(
                              nameControllerr: upDateName,
                              numberControllerr: upDateNumber,
                              onPressed: () {
                                var info = ContactsModel(
                                  name: upDateName.text,
                                  number: upDateNumber.text,
                                );
                                ctr.updateData(info, ctr.postList[index].id);
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    ),
                    SlidableAction(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.black,
                      icon: Icons.delete,
                      label: "Delete",
                      onPressed: (value) {
                        final removedContact = ctr.postList[index];
                        ctr.postList.removeAt(index);
                        Get.snackbar(
                          'Contact Deleted',
                          '${removedContact.name} has been deleted',
                          snackPosition: SnackPosition.TOP,
                        );
                        ctr.deleteData(removedContact.id.toString());
                      },
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xff7B7B7B),
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    ctr.postList[index].name.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    ctr.postList[index].number.toString(),
                  ), // Assuming ContactsModel has 'phone'
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.call,
                      color: Color(0xff08AE2D),
                      size: 30,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialogW(
                nameControllerr: nameController,
                numberControllerr: numberController,
                onPressed: () {
                  var info = ContactsModel(name: nameController.text, number: numberController.text);
                  ctr.postData(info);
                  Navigator.pop(context);
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
