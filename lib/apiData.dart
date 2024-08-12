import 'package:cloud_firestore/cloud_firestore.dart';

class todo{
  late String task;
  late bool isdone;
  todo({required this.task,required this.isdone});
 void createdata()async{
  await  FirebaseFirestore.instance.collection("user").doc().set({"isdone":isdone,"task":task});
 }
}