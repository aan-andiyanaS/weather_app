import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  String _city = 'London';
  Map<String, dynamic>? _currentWeather;

  @override
  void initState() {
    super.initState();
    _fecthWeather();
  }

  Future<void> _fecthWeather() async {
    try {
      final weatherData = await _weatherService.fectCurrrentWeather(_city);
      setState(() {
        _currentWeather = weatherData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _currentWeather == null
              ? Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1A2344),
                      Color.fromARGB(255, 125, 35, 142),
                      Colors.purple,
                      Color.fromARGB(255, 151, 44, 170),
                    ],
                  ),
                ),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              )
              : Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1A2344),
                      Color.fromARGB(255, 125, 35, 142),
                      Colors.purple,
                      Color.fromARGB(255, 151, 44, 170),
                    ],
                  ),
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      _city,
                      style: GoogleFonts.lato(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Column(
                        children: [
                          Image.network(
                            'http:${_currentWeather!['current']['condition']['icon']}',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          // Alt + 248: Hold down the Alt key and type 248 on the numeric keypad. for centigrade
                          Text(
                            '${_currentWeather!['current']['temp_c'].round()}°C',
                            style: GoogleFonts.lato(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_currentWeather!['current']['condition']['text']}',
                            style: GoogleFonts.lato(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Max : ${_currentWeather!['forecast']['forecastday'][0]['day']['maxtemp_c'].round()}°C',
                                style: GoogleFonts.lato(
                                  fontSize: 22,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Min : ${_currentWeather!['forecast']['forecastday'][0]['day']['mintemp_c'].round()}°C',
                                style: GoogleFonts.lato(
                                  fontSize: 22,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildWeatherDetail(
                          'Sunerise',
                          Icons.wb_sunny,
                          _currentWeather!['forecast']['forecastday'][0]['astro']['sunrise'],
                        ),
                        _buildWeatherDetail(
                          'Sunset',
                          Icons.brightness_3,
                          _currentWeather!['forecast']['forecastday'][0]['astro']['sunset'],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildWeatherDetail(
                          'Humidity',
                          Icons.opacity,
                          _currentWeather!['current']['humidity'],
                        ),
                        _buildWeatherDetail(
                          'wind (KPH)',
                          Icons.wind_power,
                          _currentWeather!['current']['wind_kph'],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
    );
  }

  Widget _buildWeatherDetail(String Label, IconData icon, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            padding: EdgeInsets.all(5),
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: AlignmentDirectional.bottomStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [
                  Color(0xFF1a2344).withOpacity(0.5),
                  Color(0xFF1a2344).withOpacity(0.2),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  Label,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value is String ? value : value.toString(),
                  style: GoogleFonts.lato(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
