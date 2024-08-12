import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'apiData.dart';


class fhome extends StatefulWidget {
  const fhome({super.key});

  @override
  State<fhome> createState() => _fhomeState();
}

class _fhomeState extends State<fhome> {
  final _controller=TextEditingController();
  late String task;
  late bool isdone;
  late int taskno=0;
  List<Map<String,dynamic>>model=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Center(child: Text('todo')),backgroundColor: Colors.purple,),
      body: Container(
        color: Colors.purple[200],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:StreamBuilder(stream: FirebaseFirestore.instance.collection("user").snapshots(), builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
          return ListView.builder(

            itemCount: snapshot.data!.docs.length,
              itemBuilder:(context,index){
                final user=snapshot.data!.docs;
              if(snapshot.hasData){
                return Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(30)
                  ),
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Checkbox(value: user[index]["isdone"], onChanged: (value) {
                     FirebaseFirestore.instance.collection("user").doc(user[index].id).update({"isdone":value});

                      },),
                      Expanded(child: Text("${user[index]["task"]}"))
                    ],
                  ),
                );
              }
              });
        })
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){create();},child: Icon(Icons.add),

      ),
    );
  }
  void create(){
    showDialog(context: context,
        builder: (context) {
          return AlertDialog(title: Text('New task'),
          backgroundColor: Colors.purple[100],
          content: Container(
            height: 130,
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: (){
                     task=_controller.text.toString();
                     isdone=false;
                     taskno++;

                     todo user= new todo(isdone: isdone,task: task);
                     setState(() {
                       user.createdata();
                     });
                      Navigator.pop(context);
                      _controller.clear();
                    }, child: Text("save")),
                    ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("cancel")),
                  ],
                )
              ],
            ),
          ),);
        },);
  }
  void marktrue(user,index)async{
    bool isdone=user[index]["isdone"];


  }
  
}
