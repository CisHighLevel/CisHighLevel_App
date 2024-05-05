import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prueba_flutter_2/nav_bar.dart';
import 'package:prueba_flutter_2/service/data_service.dart';
import 'package:prueba_flutter_2/widget/data_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int latestValue = 0;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    // Llama a _fetchLatestValue una vez al inicio
    _fetchLatestValue();
    // Configura un Timer para llamar a _fetchLatestValue cada 5 segundos
    Timer.periodic(Duration(seconds: 5), (timer) {
      _fetchLatestValue();
    });
  }

  Future<void> _fetchLatestValue() async {
    dynamic data = await DataService.getLatestProductValue();
    print(data);
    if (data is int) {
      setState(() {
        latestValue = data;
        progress = latestValue / 3000;
      });
    } else {
      print('Error: No se pudo obtener el valor más reciente');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DataWidget(progress: progress, text: "Luminosidad"),
          ],
        ),
      ),
    );
  }
}
