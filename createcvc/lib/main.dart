import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consultas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic _data;

  Future<dynamic> fetchData() async {
    final response = await http.get(Uri.parse('https://api-medicina-abf75-default-rtdb.firebaseio.com/Data.json'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        _data = data.values.toList();
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // Ajusta el tamaño del AppBar
        child: Container(
          color: Color.fromARGB(66, 187, 202, 252),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Image.asset(
                  'assets/medico.webp', // Ruta de la imagen
                  fit: BoxFit.cover,
                  width: 60.0,
                  height: 60.0,
                ),
              ),
              Container(
                 child:const Text(
                  'Consultas',
                  style: TextStyle(
                    fontSize: 24, // Tamaño de la fuente
                    fontWeight: FontWeight.bold, // Fuente negrita
                    fontFamily: 'Playfair Display', // Fuente elegante
                    color: Colors.black, // Color de la fuente
                  ),
                ),
                ),
            ],
          ),
        ),
      ),
      body: Center(

        
        child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  final item = _data[index];
                /*  return Column(
                    children: [
                Text('Edad: ${item['edad']}'),
                Text('Nombre y Apellido: ${item['nombre_apellido'] ?? 'N/A'}'),
                Text('Motivo de cita: ${item['motivo_cita'] ?? 'N/A'}'),
                    ],
                  );*/
                //mostrar como lista
                return  ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          width: 400,
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: const Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 199, 199, 199).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(1, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 26,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 64, 85, 155),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ('Paciente ${item['nombre_apellido'] ?? 'N/A'} de ${item['edad']}'),
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      const Text(
                     "Motivo de cita",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color.fromARGB(255, 65, 65, 65),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 300,
                      height:80,
                      child: Text(item['motivo_cita'])),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
                      ],
                    ),
                  ),
                );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}