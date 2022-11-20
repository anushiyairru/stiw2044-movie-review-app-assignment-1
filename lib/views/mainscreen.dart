import 'dart:convert';
import 'dart:async';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:keyboard_actions/keyboard_actions.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({super.key});

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  final searchController = new TextEditingController();
  String searchText = "";
  String desc = "no data";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MOREVI"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color.fromARGB(84, 57, 2, 147), Colors.black]),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/mainscreenbg4.jpg'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Search for a Movie",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: searchController,
                  style: TextStyle(color: Color.fromARGB(255, 12, 8, 8)),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "eg: loki",
                    hintStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 103, 39, 221).withOpacity(0.6)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60.0),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 214, 214, 214)
                              .withOpacity(0.6)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      getmoviedata();
                    },
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.white),
                      shape: StadiumBorder(),
                    ),
                    child: const Text("search")),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getmoviedata() async {
    var apiid = "3cc08c30";
    var url = Uri.parse(
        'http://www.omdbapi.com/?t=$searchController&apikey=3cc08c30');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        var title = parsedJson['Title'];

        desc = " is $title. The current temperature is  ";
        print(desc);
      });
    } else {
      setState(() {
        desc = "No record";
      });
    }
  }
}
