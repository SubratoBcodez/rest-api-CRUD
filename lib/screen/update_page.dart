import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iconsax/iconsax.dart';

import '../bcodez/custom.dart';
import 'home_page.dart';

class UpdatePage extends StatefulWidget {
  final Project project;
   UpdatePage({required this.project});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late TextEditingController _project_name;
  late TextEditingController _project_update;
  late TextEditingController _assigned_engineer;
  late TextEditingController _assigned_technician;
  late TextEditingController _start_date;
  late TextEditingController _end_date;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _project_name = TextEditingController(text: widget.project.projectName);
    _project_update = TextEditingController(text: widget.project.projectUpdate);
    _assigned_engineer =
        TextEditingController(text: widget.project.assignedEngineer);
    _assigned_technician =
        TextEditingController(text: widget.project.assignedTechnician);
    _start_date = TextEditingController(text: widget.project.startDate);
    _end_date = TextEditingController(text: widget.project.endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Update Details"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
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
                        TextInputType.text, _assigned_technician, (val) {
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    customButton(() async {
                      if (_formKey.currentState!.validate()) {

                        Map<String, dynamic> requestBody = {
                          "start_date": _start_date.text,
                          "end_date": _end_date.text,
                          "project_name": _project_name.text,
                          "project_update": _project_update.text,
                          "assigned_engineer": _assigned_engineer.text,
                          "assigned_technician": _assigned_technician.text
                        };

                        final response = await http.post(
                          Uri.parse('https://scubetech.xyz/projects/dashboard/update-project-elements/${widget.project.id}/'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(requestBody),
                        );

                        if (response.statusCode == 200) {
                          Get.showSnackbar(successSnack('Added Succesfully'));

                        } else if (response.statusCode == 201) {
                          Get.showSnackbar(successSnack('Added Successfully'));
                        } else {
                          Get.showSnackbar(failedSnack('Access Denied'));
                          debugPrint('Failed to update : ${response.body}');
                        }
                      }
                    }, MediaQuery.of(context).size.height * 0.075, "Update")
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

