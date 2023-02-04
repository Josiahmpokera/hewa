import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model.dart';
import 'dart:async';
import 'dart:convert';

String url =
    ("https://api.openweathermap.org/data/2.5/weather?lat=-6.8160837&lon=39.2803583&appid=acece3914bff7be493968d98f6a4420e");

// make the Data from the Internet
Future<Weather> getWeather() async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // The Data Has Arrived
    print("&&&&&&&&&&&&&&&&&&&&&&&&");

    print(response);
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load the Data");
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/bg.png'),
        fit: BoxFit.cover,
      )),
      child: Center(
          child: FutureBuilder<Weather>(
        future: futureWeather,
        builder: ((context, snapshot) {

           fToC(fah){
            final fal = fah;
            final ff = (fal - 32) * 5 /9;
            return ff;
          }

           final mm = fToC(snapshot.data!.main.temp);

           if (snapshot.hasData) {


            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.amber[800],
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      snapshot.data!.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 26),
                    )
                  ],
                ),

                const SizedBox(
                  height: 45,
                ),

                //  Number Container
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                         Text(
                          mm.toString().split('.')[0],
                          style: const TextStyle(
                            fontSize: 100,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 110, bottom: 30),
                          child: Image.asset('assets/icons/clouds.png',
                              scale: 1.7),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 70, left: 130),
                            child: const Text(
                              "°C",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 27),
                            )),
                      ],
                    ),
                  ],
                ),

                // The Caption under
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Feels like",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 07,
                        ),
                        Text(
                          "28 °C",
                          style: TextStyle(color: Colors.amber[800]),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 06,
                    ),
                    const Text(
                      "Cloudy",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                // Container Caption DONE
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  child: ListTile(
                    leading: const Icon(
                      Icons.ac_unit_rounded,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Windspeed",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      snapshot.data!.wind.speed.toString() + "km/h",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                // Container Two
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  child: const ListTile(
                    leading: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Tuesday, 04 Oct 2022",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      "17:00",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                // Container Three
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  child: ListTile(
                    leading: const Icon(
                      Icons.cloud,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Humidity",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      snapshot.data!.main.humidity.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );

// Make the Statement

          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              '${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ));
          }

          // Return const
          return CircularProgressIndicator(
            color: Colors.amber[700],
            strokeWidth: 2,
          );
        }),
      )),
    );
  }
}
