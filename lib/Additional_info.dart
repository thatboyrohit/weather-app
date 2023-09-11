import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final String value;
  final String value2;
  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.value,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(1),
          child: Column(
            children: [
              Icon(
                icon,
                size: 35,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                value2,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
