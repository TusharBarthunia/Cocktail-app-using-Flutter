import 'dart:convert';

import 'package:cocktail_app/drink_detail.dart';
import 'package:cocktail_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 var api="https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Gin";
 var res,drinks;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData()async{
    res=await http.get(Uri.parse(api));
   
    drinks=jsonDecode(res.body)["drinks"];
    print(drinks.toString());
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient:LinearGradient(colors:[
            myColor,
            Colors.orange
          ] )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text("Cocktail App",),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,

        ),
        body: Center(
          child:  res!=null ?ListView.builder(
            itemCount:drinks.length,
            itemBuilder:(context,index){
              var drink=drinks[index];
              return ListTile(
                leading: Hero(
                  tag: drink["idDrink"],
                  child: CircleAvatar(backgroundImage : NetworkImage(drink["strDrinkThumb"]))),
                title: Text("${drink["strDrink"]}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),),

                subtitle: Text("${drink["idDrink"]}",
                style: TextStyle(
                  
                  color: Colors.white
                ),),

                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DrinkDetail(drink: drink),
                  
                  ));
                },

              );
            }
          ):CircularProgressIndicator(
            backgroundColor: Colors.black,
          ),
        ),

      ),
    );
  }
}

