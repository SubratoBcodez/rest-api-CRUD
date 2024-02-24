

import 'package:flutter_job_task/screen/add_page.dart';
import 'package:flutter_job_task/screen/home_page.dart';
import 'package:flutter_job_task/screen/update_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

const String home_page='/homepage';
const String add_page= '/add_page';
const String update_page= '/update_page';

List <GetPage> getPages=[


  GetPage(name: home_page, page: ()=>HomePage()),
  GetPage(name: add_page, page: ()=>AddPage()),
  GetPage(name: update_page, page: ()=>UpdatePage(
    project: Get.arguments,
  ))
];