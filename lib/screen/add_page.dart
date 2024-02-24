import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_job_task/bcodez/custom.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _project_name = TextEditingController();
  final TextEditingController _project_update = TextEditingController();
  final TextEditingController _assigned_engineer = TextEditingController();
  final TextEditingController _ssigned_technician = TextEditingController();
  final TextEditingController _start_date = TextEditingController();
  final TextEditingController _end_date = TextEditingController();

  Future<void> addData(requestBody) async {
    final response = await http.post(
      Uri.parse(
          'https://scubetech.xyz/projects/dashboard/add-project-elements/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      Get.showSnackbar(successSnack('Added Successfully'));
      debugPrint('ok: ${response.body}');
    } else if (response.statusCode == 201) {
      Get.showSnackbar(successSnack('Added Successfully'));
      debugPrint('OK : ${response.body}');
    } else {
      Get.showSnackbar(failedSnack('Something Wrong'));
      debugPrint('Failed to add : ${response.body}');
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Add Details"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            // aTxt("Add Details Page", Colors.black, FontWeight.normal),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),

            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    customText("Project Name", Iconsax.document,
                        TextInputType.text, _project_name, (val) {
                      if (val!.isEmpty) {
                        return "can't be empty";
                      }
                    }),
                    SizedBox(height: 10),
                    customText("Project Update", Iconsax.document,
                        TextInputType.text, _project_update, (val) {
                      if (val!.isEmpty) {
                        return "can't be empty";
                      }
                    }),
                    SizedBox(height: 10),
                    customText("Assigned Engineer", Iconsax.profile_tick,
                        TextInputType.text, _assigned_engineer, (val) {
                      if (val!.isEmpty) {
                        return "can't be empty";
                      }
                    }),
                    SizedBox(height: 10),
                    customText("Assigned Tech", Iconsax.profile_2user,
                        TextInputType.text, _ssigned_technician, (val) {
                      if (val!.isEmpty) {
                        return "can't be empty";
                      }
                    }),
                    SizedBox(height: 10),
                    customDate(_start_date, () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _start_date.text =
                              "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                        });
                      }
                    }, "Start Date"),
                    SizedBox(height: 10),
                    customDate(_end_date, () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _end_date.text =
                              "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                        });
                      }
                    }, "End Date"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    customButton(() async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> requestBody = {
                          "start_date": _start_date.text,
                          "end_date": _end_date.text,
                          "project_name": _project_name.text,
                          "project_update": _project_update.text,
                          "assigned_engineer": _assigned_engineer.text,
                          "assigned_technician": _ssigned_technician.text
                        };
                        addData(requestBody);
                      }
                    }, MediaQuery.of(context).size.height * 0.075, "Submit")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
