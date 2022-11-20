import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class secondmain extends StatefulWidget {
  const secondmain({super.key});

  @override
  State<secondmain> createState() => _secondmainState();
}

class _secondmainState extends State<secondmain> {
  TextEditingController userSearchValue = TextEditingController();
  var value =
      "https://i.pinimg.com/564x/10/fa/e3/10fae3da91c311c44944d0e6e8da5404.jpg";
  String desc1 = "",
      desc2 = "",
      desc3 = "",
      desc4 = "",
      desc5 = "",
      desc6 = "",
      desc7 = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          "MOREVI",
        )),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/confirmmain.jpg"),
                fit: BoxFit.cover),
          ),
          //widget that allows scrolling and avoid overflowing
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 8,
                ),
                const Text("Search the movie here",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                //search textfield with icon button call the method when onpressed
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: userSearchValue,
                        style: const TextStyle(
                            color: Colors.purple,
                            backgroundColor: Colors.white),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Eg.batman',
                            suffixIcon: IconButton(
                                onPressed: getMovieData,
                                icon: const Icon(Icons.search)),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 8,
                                  color: Colors.pink,
                                ),
                                borderRadius: BorderRadius.circular(50.0))),
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
                //end of search textfield

                const SizedBox(
                  height: 4,
                ),

                //text that will display the retrieved data of title
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(desc1,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 237, 231, 238),
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ),
                // end of title description

                //the widget that allows the default image as as a placeholder and fades
                // out when the poster is retrived
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Color.fromARGB(255, 252, 250, 255)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: FadeInImage.assetNetwork(
                          height: 350,
                          width: 300,
                          placeholder: 'assets/images/defaultimg.jpg',
                          image: value),
                    ),
                  ),
                ),
                //end of image

                const SizedBox(
                  height: 6,
                ),

                //text that will display the retrieved data of ratings
                Text(desc2,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                //end of rating description

                const SizedBox(
                  height: 4,
                ),

                //text that will display the retrieved data of genre
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Chip(
                    label: Text(desc3,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.purple,
                    side: const BorderSide(
                        width: 5, color: Color.fromARGB(255, 216, 209, 209)),
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  ),
                ),
                //end of genre description

                const SizedBox(
                  height: 12,
                ),

                //text that will display the retrieved data of runtime
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Text(desc6,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      //end of runtime description

                      const SizedBox(
                        height: 12,
                      ),
                      //text that will display the retrieved data of plot
                      Text(desc4,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      //end of plot description

                      const SizedBox(
                        height: 12,
                      ),

                      //text that will display the retrieved data of director
                      Text(desc7,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      //end of director description

                      const SizedBox(
                        height: 12,
                      ),

                      //text that will display the retrieved data of releases date
                      Text(desc5,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                //end of released date description

                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getMovieData() async {
    String newText = userSearchValue.text;
    ProgressDialog progreswidget = ProgressDialog(context,
        message: const Text("Loading",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple)),
        title: const Text("Please wait..."));
    progreswidget.show();
    userSearchValue.clear();
    var apiid = "3cc08c30";
    var url = Uri.parse('https://www.omdbapi.com/?t=$newText&apikey=$apiid');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        var title = parsedJson["Title"];
        var runtime = parsedJson["Runtime"];
        var release = parsedJson["Released"];
        var director = parsedJson["Director"];
        var rate = parsedJson["Ratings"][0]["Value"];
        var genre = parsedJson["Genre"];
        var plot = parsedJson["Plot"];
        String poster = parsedJson['Poster'];
        value = poster;
        Image.network(value);
        desc1 = "$title";
        desc2 = "Rated $rate";
        desc3 = "$genre";
        desc4 = "\t\t\t\t\t Plot: $plot";
        desc5 = "Release date: $release \t\t\t\t\t\t";
        desc6 =
            "Runtime: $runtime \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t";
        desc7 = "Director: $director \t\t\t\t\t\t\t\t\t\t\t";

        Fluttertoast.showToast(
            backgroundColor: Colors.purple,
            msg: "Movie Found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 4,
            fontSize: 16.0);
      });
    } else {
      setState(() {
        desc1 = "No record";
      });
    }
    progreswidget.dismiss();
  }
}

 //the api returns result, then the response code is checked.
    //It checks the statusCode of the response and if it is 200,
    //it decodes the JSON data into a JavaScript object called
    //parsedJson.