import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_job_task/bcodez/custom.dart';
import 'package:flutter_job_task/bcodez/route.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Project>> fetchProjects() async {
    final response = await http.get(Uri.parse('https://scubetech.xyz/projects/dashboard/all-project-elements/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Project> projects = [];
      for (var project in data) {
        projects.add(Project.fromJson(project));
      }
      return projects;
    } else {
      throw Exception('Failed to load projects');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProjects();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAECEE),
      appBar: homeAppBar("Project Details"),
      body: FutureBuilder<List<Project>>(
        future: fetchProjects(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  // onTap: (){
                  //   print(snapshot.data![index]);
                  // },
                  onTap: ()=> Get.toNamed(update_page, arguments: snapshot.data![index]),
                  child: Container(
                    padding: const EdgeInsets.only(top:10,left: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    height: MediaQuery.of(context).size.height*0.14,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Project Name : ${snapshot.data![index].projectName}',style: const TextStyle(fontWeight: FontWeight.bold),),
                        Text('Update: ${snapshot.data![index].projectUpdate}'),
                        Text('Assigned Engineer: ${snapshot.data![index].assignedEngineer}'),
                        Text('Assigned Technician: ${snapshot.data![index].assignedTechnician}'),
                        Text('Start From ${snapshot.data![index].startDate} to ${snapshot.data![index].endDate}'),

                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),


      floatingActionButton: FloatingActionButton(
          child: const Icon(Iconsax.card_edit),
          onPressed: () {
            Get.toNamed(add_page);
          }),
    );
  }
}

class Project {
  final int id;
  final String startDate;
  final String endDate;
  final String projectName;
  final String projectUpdate;
  final String assignedEngineer;
  final String assignedTechnician;
  final int duration;

  Project({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.projectName,
    required this.projectUpdate,
    required this.assignedEngineer,
    required this.assignedTechnician,
    required this.duration

  });
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
        id: json['id'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        projectName: json['project_name'],
        projectUpdate: json['project_update'],
        assignedEngineer: json['assigned_engineer'],
        assignedTechnician: json['assigned_technician'],
        duration: json['duration']
    );
  }
}
