import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/detail_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List pokedex = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      fetchPokemonData();

    }
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text('Pokedex', style: TextStyle(
          color: Colors.black.withOpacity(0.6),
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.search,color: Colors.black.withOpacity(0.6), size: 30,),
          )
        ],
      ),
        backgroundColor: Colors.white,
        body: Stack(
            children: [
              Positioned(
                top: 10,
                bottom: 0,
                width: width,
                child: Column(
                  children: [
                    pokedex!= null ? Expanded(
                        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1
                        ),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics()
                            ,itemCount: pokedex.length,itemBuilder:(context, index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                child: InkWell(
                                  child: SafeArea(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: pokedex[index]['type'][0] == "Grass" ? Colors.greenAccent : pokedex[index]['type'][0] == "Fire" ? Colors.redAccent
                                              : pokedex[index]['type'][0] == "Water" ? Colors.blue : pokedex[index]['type'][0] == "Poison" ? Colors.deepPurpleAccent
                                              : pokedex[index]['type'][0] == "Electric" ? Colors.amber : pokedex[index]['type'][0] == "Rock" ? Colors.grey
                                              : pokedex[index]['type'][0] == "Ground" ? Colors.brown : pokedex[index]['type'][0] == "Psychic" ? Colors.indigo
                                              : pokedex[index]['type'][0] == "Fighting" ? Colors.orange : pokedex[index]['type'][0] == "Bug" ? Colors.lightGreenAccent
                                              : pokedex[index]['type'][0] == "Ghost" ? Colors.deepPurple : pokedex[index]['type'][0] == "Normal" ? Colors.black26 : Colors.pink,

                                          borderRadius: BorderRadius.all(Radius.circular(25))
                                      ),


                                      child: Stack(
                                        children: [
                                          Positioned(
                                            bottom: -10,
                                            right: -10,
                                            child: Image.asset('assets/pokeball.png',
                                              height: 100,
                                              fit: BoxFit.fitHeight,

                                            ),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                            right: 5,
                                            child: Hero(
                                              tag: index,
                                              child: CachedNetworkImage(imageUrl: pokedex[index]['img'],
                                                  height: 100,
                                                  fit: BoxFit.fitHeight,
                                                  placeholder: (context,url) => Center(
                                                    child: CircularProgressIndicator(),
                                                  )
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 55,
                                            left: 15,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left:10.0, right: 10, top: 5, bottom: 5),
                                                child: Text(pokedex[index]['type'][0], style: TextStyle(color: Colors.white,
                                                    shadows: [
                                                      BoxShadow(
                                                          color: Colors.blueGrey,
                                                          offset: Offset(0,0),
                                                          spreadRadius: 1.0,
                                                          blurRadius: 15
                                                      )
                                                    ]
                                                ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  color: Colors.black.withOpacity(0.5)
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 30,
                                            left: 15,
                                            child: Text(pokedex[index]['name'],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white,
                                                shadows: [
                                                  BoxShadow(
                                                      color: Colors.blueGrey,
                                                      offset: Offset(0,0),
                                                      spreadRadius: 1.0,
                                                      blurRadius: 15
                                                  )
                                                ]
                                            ),

                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(heroTag: index, pokemonDetail: pokedex[index],
                                      color: pokedex[index]['type'][0] == "Grass" ? Colors.greenAccent : pokedex[index]['type'][0] == "Fire" ? Colors.redAccent
                                          : pokedex[index]['type'][0] == "Water" ? Colors.blue : pokedex[index]['type'][0] == "Poison" ? Colors.deepPurpleAccent
                                          : pokedex[index]['type'][0] == "Electric" ? Colors.amber : pokedex[index]['type'][0] == "Rock" ? Colors.grey
                                          : pokedex[index]['type'][0] == "Ground" ? Colors.brown : pokedex[index]['type'][0] == "Psychic" ? Colors.indigo
                                          : pokedex[index]['type'][0] == "Fighting" ? Colors.orange : pokedex[index]['type'][0] == "Bug" ? Colors.lightGreenAccent
                                          : pokedex[index]['type'][0] == "Ghost" ? Colors.deepPurple : pokedex[index]['type'][0] == "Normal" ? Colors.white70 : Colors.pink,
                                    )));
                                  },
                                ),
                              );
                            })
                    ): Center(
                      child: CircularProgressIndicator(),
                    )

                  ],
                ),
              ),

              Positioned(
                top: 0,
                child: Container(
                  height: 150,
                  width: width,
                ),
              ),
            ]
        )
    );
  }

  void fetchPokemonData(){
    var url = Uri.https('raw.githubusercontent.com', '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    http.get(url).then((value) {
      if(value.statusCode == 200){
        var data = jsonDecode(value.body);
        pokedex = data['pokemon'];
        setState(() {});
        print(pokedex);
      }
    }).catchError((e){
      print(e);
    });

  }
}