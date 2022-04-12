import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<MyApp> {
  var temp = 20.0;
  var city;
  var humidity;
  var windSpeed;

  Future getWeatherData() async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=chennai&appid=be29f428d84021f9fdd695baf4286754";
    http.Response response = await http.get(Uri.parse(url));
    var result = jsonDecode(response.body);
    print(result['main']['temp']);
    setState(() {
      this.temp = result['main']['temp'] - 273;
      this.humidity = result['main']['humidity'];
      this.windSpeed = result['wind']['speed'];
    });
    return response;
  }

  @override
  void initState() {
    super.initState();

    getWeatherData();
    print(temp);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/night.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Text(temp.toStringAsFixed(1) + '\u2103',

                        // ignore: prefer_const_constructors
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text('Chennai',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          )))),
                  Row(children: [
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.width * 0.25,
                            child: Text(
                              'Humidity : $humidity',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                fontSize: 20.0,
                              )),
                            ),
                          ),
                        ))
                  ])
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }
}
