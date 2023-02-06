import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import '../modal/search_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Dataa extends StatefulWidget {

  String reg;
  Dataa({ required this.reg, super.key,});

  String url =
      ("https://api.openweathermap.org/data/2.5/weather?q=Dodoma&appid=acece3914bff7be493968d98f6a4420e");

  //Make the Function to get the value of the search

  String getValue(theValue){
    final newValue = reg;
    return newValue;
  }


  Future<Regions> getRegions() async {

    final newName = getValue(reg);


    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Data is Here");
      print(newName);
      return Regions.fromJson(jsonDecode(response.body));

    } else {
      print("!!!!!!!!!!!!!!!!!!!!!!");
      print(reg);
      throw Exception("Something is wrong");
    }
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class Result extends StatefulWidget {

   String search;

  Result({super.key, required this.search});

   makeD(){
    final newData = search;
    return newData;
  }

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late Future<Regions> futureRegion;

  final Dataa getD = new Dataa(reg: "");



  @override
  void initState() {
    super.initState();
    futureRegion = getD.getRegions();


  }

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();

    String formattedDate = DateFormat.yMMMEd().format(now);

    String timeNow = DateFormat.Hm().format(now);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1E60B9),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
        child: FutureBuilder(
          future: futureRegion,
          builder: ((context, snapshot) {

            fToC(fah){
              final fal = fah;
              final ff = (fal - 32) * 5 /9;
              return ff;
            }

            final mm = fToC(snapshot.data!.main.temp);

            if (snapshot.hasData) {
              print("Data is available");
              return Center(
                  child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.amber[600],
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          snapshot.data!.name,
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // The Subtext in Bottom
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            letterSpacing: 2),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Center Contaner
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Text(
                              "$mm°".toString().split('.')[0],
                              style: const TextStyle(
                                  fontSize: 90,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 110),
                              child: Text(
                                snapshot.data!.weather[0].main,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 100, top: 55),
                              child: Image.asset('assets/icons/clouds.png'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Another Rain VIew Container
                  const SizedBox(
                    height: 15,
                  ),

                  Container(
                    margin: const EdgeInsets.all(25),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(106, 243, 243, 243)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/umbrella.png',
                                scale: 1.6,
                              ),
                              Text(
                                snapshot.data!.rain.the1H.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                              const Text("Rain"),
                            ],
                          ),
                        ),

                        // Second
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/water.png',
                                scale: 1.6,
                              ),
                              Text(
                                snapshot.data!.main.humidity.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                              const Text("Humidity"),
                            ],
                          ),
                        ),

                        // Third
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/wind.png',
                                scale: 1.6,
                              ),
                              Text(
                                "${snapshot.data!.wind.speed} km/h",
                                style: const TextStyle(fontSize: 20),
                              ),
                              const Text("Wind"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                '${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ));
            }

            return Center(
              heightFactor: 1,
              widthFactor: 1,
              child: CircularProgressIndicator(
                color: Colors.amber[700],
                strokeWidth: 2,
              ),
            );
          }),
        ),
      ),
    );
  }
}
