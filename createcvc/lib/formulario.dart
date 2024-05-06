// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const apiUrl = 'http://localhost:3000/pacientes';

class PatientForm extends StatefulWidget {
  const PatientForm({super.key});

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final _controllerNombre = TextEditingController();
  final _controllerGmail = TextEditingController();
  final _controllerDoctor = TextEditingController();
  final _controllerTipoCita = TextEditingController();

  @override
  void dispose() {
    _controllerNombre.dispose();
    _controllerGmail.dispose();
    _controllerDoctor.dispose();
    _controllerTipoCita.dispose();
    super.dispose();
  }

  Future<void> _sendPatientData() async {
    try {
      final patientData = {
        "Nombre_Paciente": _controllerNombre.text,
        "gmail": _controllerGmail.text,
        "Doctor": _controllerDoctor.text,
        "Tipo_Cita": _controllerTipoCita.text,
      };

      final jsonBody = jsonEncode(patientData);

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Data sent successfully
        _showSnackBar('Data sent successfully');
      } else {
        // Failed to send data
        _showSnackBar('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any other errors
      _showSnackBar('An error occurred: $e');
    }
  }

  Future<List<dynamic>> _getPatientData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 300,
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildTextField('Nombre del paciente', _controllerNombre),
        _buildTextField('Gmail', _controllerGmail),
        _buildTextField('Doctor', _controllerDoctor),
        _buildTextField('Tipo de cita', _controllerTipoCita),
        ElevatedButton(
          onPressed: _sendPatientData,
          child: Text('Send Data'),
        ),
        ElevatedButton(
          onPressed: () async {
            final patientData = await _getPatientData();
            _showPatientData(patientData);
          },
          child: Text('Get Data'),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  void _showPatientData(List<dynamic> patientData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Patient Data'),
          content: ListView.builder(
            itemCount: patientData.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(patientData[index].toString()),
              );
            },
          ),
        );
      },
    );
  }
}