import 'dart:io';

import 'package:eeg_processing/charts.dart';
import 'package:eeg_processing/data_processing.dart';
import 'package:eeg_processing/models.dart';
import 'package:file_picker/file_picker.dart';

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
      body: Column(
        children: [
          Center(
            
              child: ElevatedButton(
                  onPressed: () async {
                    // final Directory tempDir =
                    //     await getApplicationDocumentsDirectory();
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
              
                    if (result != null) {
                      File file = File(result.files.single.path!);
                      final String fileContent = await file.readAsString();
                      setState(() {
                        parseData(fileContent);
                      });
                    }
                    // final File file = File('${tempDir.path}\\EEG_3c_04.txt');
              
                    // final String fileContent = await file.readAsString();
              
                    // setState(() {parseData(fileContent);});
                  },
                  child: const Text("Начать")),
            
          ),
          GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx > 0) {
                setState(() {
                  customMinX += 0.01;
                  customMaxX += 0.01;
                });
              } else if (details.delta.dx < 0) {
                setState(() {
                  customMinX -= 0.01;
                  customMaxX -= 0.01;
                });
              }
            },
            onDoubleTap: () {
              setState(() {
                customMinX = 0;
                customMaxX = 4;
              });
            },
            child: Column(children: [
              SizedBox(height: 200,
                child: channel1.isNotEmpty
                    ? lineChart(channel1, customMinX, customMaxX)
                    : SizedBox(
                        child: Container(
                          color: Colors.red,
                        ),
                      ),
              ),
              SizedBox(height: 200,
                child: channel2.isNotEmpty
                    ? lineChart(channel2,customMinX, customMaxX)
                    : SizedBox(
                        child: Container(
                          color: Colors.blue,
                        ),
                      ),
              ),
              SizedBox(height: 200,
                child: channel3.isNotEmpty
                    ? lineChart(channel3,customMinX, customMaxX)
                    : SizedBox(
                        child: Container(
                          color: Colors.green,
                        ),
                      ),
              ),
            ]),
          ),
          //    Expanded( child:  channel1.isNotEmpty ? lineChart(channel1,customMinX,customMaxX): SizedBox(child: Container(color: Colors.red,),),)),
          // // Expanded(child: channel2.isNotEmpty? lineChart(channel2): SizedBox(child: Container(color: Colors.blue,),),),
          // // Expanded(child: channel3.isNotEmpty? lineChart(channel3): SizedBox(child: Container(color: Colors.green,),),),
        ],
      ),
    );
  }
}

// GEsture detector внутрь функции графика, нужно чтобы у каждого был свой скейл