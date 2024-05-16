import 'package:flutter/material.dart';

class header extends StatelessWidget implements PreferredSizeWidget {
  const header({super.key,required this.size});
  final size; 

 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: preferredSize.height,
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text("Fit Track",style: TextStyle(fontSize: 30,fontFamily: 'inter',fontWeight: FontWeight.w900)),
    ));
  }

  @override
  Size get preferredSize => Size.fromHeight(size.height*0.08);
}
