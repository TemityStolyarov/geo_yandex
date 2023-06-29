import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MainApp());
}

String getTileURL(lat, lon, zoom) {
  int xTile = ((lon + 180) / 360 * (1 << zoom)).floor();
  int yTile = ((1 - (log(tan(lat * pi / 180) + 1 / cos(lat * pi / 180)) / pi)) /
          2 *
          (1 << zoom))
      .floor();
  return "https://core-carparks-renderer-lots.maps.yandex.net/maps-rdr-carparks/tiles?l=carparks&x=$xTile&y=$yTile&z=$zoom&scale=1&lang=ru_RU";
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double? lat;
  double? lon;
  int? zoom;
  String? _path;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: Colors.indigo,
            elevation: 0,
            title: const Center(
              child: Text('GEO'),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    _path ?? 'Некоторые значения не заданы',
                    style: const TextStyle(
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextField(
                      cursorColor: Colors.indigo,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        ),
                        hintText: 'Широта',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          try {
                            lat = double.parse(value);
                          } catch (e) {
                            lat = null;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextField(
                      cursorColor: Colors.indigo,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        ),
                        hintText: 'Долгота',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          try {
                            lon = double.parse(value);
                          } catch (e) {
                            lon = null;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextField(
                      cursorColor: Colors.indigo,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        ),
                        hintText: 'Приближение',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          try {
                            zoom = int.parse(value);
                          } catch (e) {
                            zoom = null;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                      'Ш: ${lat ?? 'не задано'} | Д: ${lon ?? 'не задано'} | П: ${zoom ?? 'не задано'}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.indigo),
                    ),
                    onPressed: () {
                      String path;
                      if (lat != null && lon != null && zoom != null) {
                        path = getTileURL(lat, lon, zoom);
                      } else {
                        path = 'Некоторые значения не заданы';
                      }
                      setState(() {
                        _path = path;
                        print(path);
                      });
                    },
                    child: const Text('Вычислить'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
