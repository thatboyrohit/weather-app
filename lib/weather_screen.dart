import 'dart:convert';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';

import 'hourly_info.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Additional_info.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {


  Future<Map<String , dynamic>> getCurrentWeather() async{
    try{
      String cityName = 'Himachal Pradesh';
      final res = await  http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'),
      );
     final data = jsonDecode(res.body);
     if (data['cod']!= '200'){
       throw ' an unexpected error occurred';
     }
     return data;
       // temp = data['list'][0]['main']['temp'];
    }
    catch(e){
      throw e.toString();
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Weather', style: TextStyle(fontStyle: FontStyle.italic),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather() ,
        builder: (context , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child:  CircularProgressIndicator.adaptive());
        }
        if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()));
        }
        final data = snapshot.data!;
        final currentTemp = data['list'][0]['main']['temp'];
        var currentSky = data['list'][0]['weather'][0]['main'];
        final currentPressure =  data['list'][0]['main']['pressure'];
        final currentHumidity =  data['list'][0]['main']['humidity'];
        final currentWindSpeed =  data['list'][0]['wind']['speed'];

          return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //main card
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child:  Padding(
                        padding:const  EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '$currentTemp K',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                           const  SizedBox(
                              height: 20,
                            ),
                            Icon(
                            currentSky =='Clouds' || currentSky == 'Rain' ?  Icons.cloud : Icons.sunny,
                              size: 64,
                            ),
                          const  SizedBox(
                              height: 20,
                            ),
                            Text(
                              '$currentSky',
                              style: const TextStyle(fontSize: 30),
                            ),
                          const  SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hourly Forecast',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 16,
              ),

              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context , index){
                      final hourlyForecast = data['list'][index+1];
                    final hourlySky =  hourlyForecast['weather'][0]['main'];
                    final hourlyTemperature = hourlyForecast['main']['temp'].toString();
                    final time = DateTime.parse(hourlyForecast['dt_txt']);
                  return HourlyForecastItem(
                    time: DateFormat.j().format(time),
                    temperature: hourlyTemperature,
                    icon:hourlySky == 'Clouds' || hourlySky == 'Rain' ? Icons.cloud : Icons.sunny,
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Additional Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfo(
                    icon: Icons.water_drop_outlined,
                    value: 'Humidity',
                    value2: currentHumidity.toString(),
                  ),
                  AdditionalInfo(
                    icon: Icons.waves,
                    value: 'Wind Speed',
                    value2: currentWindSpeed.toString(),
                  ),
                  AdditionalInfo(
                    icon: Icons.gas_meter,
                    value: 'Pressure',
                    value2: currentPressure.toString(),
                  ),
                ],
              ),
            ]),
          ),
        );
        },
      ),
    );
  }
}
