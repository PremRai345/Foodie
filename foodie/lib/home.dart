import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodie/model.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=d1b38b35&app_key=47593eddf2b911e5e1041812ee4475b8";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    log(data.toString());

    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);

      log(recipeList.toString());
    });
    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("Ladoo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff213A50),
                  Color(0xff071938),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SafeArea(
                child: Container(
                  //Search Wala Container

                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll(" ", "") ==
                              "") {
                            print("Blank search");
                          } else {
                            getRecipe(searchController.text);
                          }
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Lets Cook Somethings"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: const [
                    Text(
                      "What do you want to cook?",
                      style: TextStyle(fontSize: 33, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text("Lets Cook!",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
