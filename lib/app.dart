import 'package:call_app_getx/routes/app_route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home/binding/home_binding.dart';
import 'home/view/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('en', 'UK'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ).copyWith(
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
      initialRoute: GetAppRouter.home,
      getPages: [
        GetPage(
          name: GetAppRouter.home,
          binding: HomeBindings(),
          page: () => HomePage(),
        ),
      ],
    );
  }
}
