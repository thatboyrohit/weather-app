import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;
  const HourlyForecastItem(
      {super.key,
      required this.icon,
      required this.temperature,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              time,
              maxLines:1 ,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Icon(
              icon,
              size: 32,
            ),
            SizedBox(
              height: 10,
            ),
            Text(temperature),
          ],
        ),
      ),
    );
  }
}
