import 'dart:io';

import 'package:eeg_processing/data_processing.dart';
import 'package:eeg_processing/models.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Приложение для обработки ЭЭГ сигнала"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              final Directory tempDir =
                  await getApplicationDocumentsDirectory();
              final File file = File('${tempDir.path}\\EEG_3c_04.txt');

              final String fileContent = await file.readAsString();
              parseData(fileContent);
              print(channel1);
              print(channel2);
              print(channel3);
            },
            child: const Text("Начать")),
      ),
    );
  }
}
