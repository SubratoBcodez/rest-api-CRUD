

import 'package:flutter/material.dart';
import 'package:flutter_job_task/bcodez/route.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

Widget customText(hint, prefixIcon, keyboardType, contrller, validator,
    {obscureText = false}) {
  return TextFormField(
      keyboardType: keyboardType,
      controller: contrller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: hint,
        // hintText: hint,

        prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
          )
      ));
}
Widget customDate (controller,ontap,text) {
  return TextField(
    controller: controller,
    readOnly: true,

    onTap: ontap,
    decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(Iconsax.calendar_1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      )

    ),
  );
}
Widget customButton(onTap,height,title) {
  return InkWell(
    onTap: onTap,
    splashColor: Colors.red,
    borderRadius: BorderRadius.circular(8),
    child: Ink(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.redAccent),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    ),
  );
}


Text aTxt(txt,clr,fsz,fwt){
  return Text(
    txt,
    style: TextStyle(
        color: clr,
        fontSize:fsz,
        fontWeight: fwt),
  );
}

AppBar customAppBar (title){
  return AppBar(
    leading: IconButton(
      icon: const Icon(
        Iconsax.arrow_left_2,

        color: Colors.white
      ),
      iconSize: 28,
      onPressed: ()=> Get.back(),
    ),
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: Colors.indigo,
  );
}

AppBar homeAppBar (title){
  return AppBar(
    leading: Icon(
          Iconsax.home_1,
size: 28,
          color: Colors.white
      ),

    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: Colors.indigo,
  );
}

GetSnackBar failedSnack(message) => GetSnackBar(
  message: message,
  duration: Duration(seconds: 2),
  backgroundColor: Colors.red,
  icon: Icon(Icons.warning),
);

GetSnackBar successSnack(message) => GetSnackBar(
  message: message,
  duration: Duration(seconds: 2),
  backgroundColor: Colors.green,
  icon: Icon(Icons.done),
);
