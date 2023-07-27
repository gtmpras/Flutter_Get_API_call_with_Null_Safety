import 'dart:convert';

import 'package:api_practice/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<post_modle> postList=[];
  Future<List<post_modle>?> getPostApi()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data= jsonDecode(response.body.toString());
    if (response.statusCode==200){
      postList.clear();
      for (Map<String,dynamic> i in data)
{
       postList.add(post_modle.fromJson(i));
      }
      return postList;
    }else {

    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('API integration'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Text('Loading...');
              }else{
                return ListView.builder(
                  itemCount:postList.length ,
                  itemBuilder: ((context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('Title',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold ),),
                           Text(postList[index].title.toString()),
                           SizedBox(height: 5,),
                          Text('Description',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold ),),
                           Text(postList[index].body.toString()),
                           SizedBox(height: 5,),
                        ],
                      ),
                    ),
                  );

                 
                })
                );
              }
            })),
          
        ],
      ),
    );
  }
}