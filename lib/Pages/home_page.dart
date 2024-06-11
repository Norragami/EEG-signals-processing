import 'dart:io';
import 'package:eeg_processing/Pages/statistics.dart';
import 'package:eeg_processing/other/other.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

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
          const SizedBox(height: 15,),
          Expanded(
            flex: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
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
                            dropDownIndex = 1;
                            
                          });
                        }
                        // final File file = File('${tempDir.path}\\EEG_3c_04.txt');

                        // final String fileContent = await file.readAsString();

                        // setState(() {parseData(fileContent);});
                      },
                      child: const Text(
                        "Выбрать файл",
                        style: TextStyle(color: Colors.black),
                      )),
                  ElevatedButton(
                    onPressed: () {
                      if(channel1Temp.isNotEmpty&&channel2Temp.isNotEmpty&&channel3Temp.isNotEmpty){
                        
                      
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Статистика",
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              content: DataTable(columns: const [
                                DataColumn(
                                    label: Text("Параметр",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ))),
                                DataColumn(
                                    label: Text("Канал 1",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ))),
                                DataColumn(
                                    label: Text("Канал 2",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ))),
                                DataColumn(
                                    label: Text("Канал 3",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ))),
                              ], rows: setRows(channel1, channel2, channel3)),
                            );
                          });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Выберите файл"),
                        ));
                      }
                    },
                    child: const Text(
                      "Статистика",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    saveData(channel1, channel2, channel3);
                  },
                   child: const Text("Сохранить сигналы",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),),),
                  DropdownButton(
                    value: dropDownIndex,
                    menuMaxHeight: 300.0,
                    borderRadius: BorderRadius.circular(10),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Исходные сигналы"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("ФНЧ"),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("ФНЧ+Фильтр сетевой наводки"),
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Text("ФНЧ+50Гц+Удаление тренда"),
                      ),
                      DropdownMenuItem(
                        value: 5,
                        child: Text("\u03B2-ритм"),
                      )
                    ],
                    onChanged: (e) {
                      switch (e) {
                        case 1:
                          setState(() {
                            dropDownIndex = 1;
                            channel1Temp = channel1;
                            channel2Temp = channel2;
                            channel3Temp = channel3;
                          });
                          break;
                        case 2:
                          {
                            setState(() {
                              dropDownIndex = 2;
                              channel1Temp = LowPassFilter.filter(channel1);
                              channel2Temp = LowPassFilter.filter(channel2);
                              channel3Temp = LowPassFilter.filter(channel3);
                            });
                          }
                          break;
                        case 3:
                          {
                            setState(() {
                              dropDownIndex = 3;
                              // channel1Temp = channel1Temp.sublist(175,channel1Temp.length);
                              // channel2Temp = channel2Temp.sublist(175,channel2Temp.length);
                              // channel3Temp = channel3Temp.sublist(175,channel3Temp.length);
                              channel1Temp = Filter50Hz.filter(
                                  LowPassFilter.filter(channel1));
                              channel2Temp = Filter50Hz.filter(
                                  LowPassFilter.filter(channel2));
                              channel3Temp = Filter50Hz.filter(
                                  LowPassFilter.filter(channel3));
                            });

                            break;
                          }
                        case 4:
                          {
                            setState(() {
                              dropDownIndex = 4;
                              channel1Temp = Detrend.detrend(Filter50Hz.filter(
                                  LowPassFilter.filter(channel1)));
                              channel2Temp = Detrend.detrend(Filter50Hz.filter(
                                  LowPassFilter.filter(channel2)));
                              channel3Temp = Detrend.detrend(Filter50Hz.filter(
                                  LowPassFilter.filter(channel3)));
                            });
                          }
                          break;
                        case 5:
                          {
                            setState(() {
                              dropDownIndex = 5;
                              channel1Temp = BandPassFilter.filter(
                                  LowPassFilter.filter(channel1));
                              channel2Temp = BandPassFilter.filter(
                                  LowPassFilter.filter(channel2));
                              channel3Temp = BandPassFilter.filter(
                                  LowPassFilter.filter(channel3));
                              // channel1Temp = Detrend.detrend(BandPassFilter.filter(LowPassFilter.filter(channel1)));
                              // channel2Temp = Detrend.detrend(BandPassFilter.filter(LowPassFilter.filter(channel2)));
                              // channel3Temp = Detrend.detrend(BandPassFilter.filter(LowPassFilter.filter(channel3)));
                            });
                          }
                          break;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          // 1 КАНАЛ
          Expanded(
            child: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 0) {
                  setState(() {
                    customMinX1 += 0.01;
                    customMaxX1 += 0.01;
                  });
                } else if (details.delta.dx < 0) {
                  setState(() {
                    customMinX1 -= 0.01;
                    customMaxX1 -= 0.01;
                  });
                }
              },
              onDoubleTap: () {
                setState(() {
                  customMinX1 = 0;
                  customMaxX1 = channel1Temp.length / 250;
                });
              },
              child: SizedBox(
                height: 300,
                child: channel1Temp.isNotEmpty
                    ? lineChart(channel1Temp, customMinX1, customMaxX1)
                    : const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: SizedBox(
                            child: Text(
                          'Нет данных по 1-му каналу, выберите файл',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
              ),
            ),
          ),
          // 2 КАНАЛ
          Expanded(
            child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dx > 0) {
                    setState(() {
                      customMinX2 += 0.01;
                      customMaxX2 += 0.01;
                    });
                  } else if (details.delta.dx < 0) {
                    setState(() {
                      customMinX2 -= 0.01;
                      customMaxX2 -= 0.01;
                    });
                  }
                },
                onDoubleTap: () {
                  setState(() {
                    customMinX2 = 0;
                    customMaxX2 = channel2Temp.length / 250;
                  });
                },
                child: SizedBox(
                  height: 300,
                  child: channel2Temp.isNotEmpty
                      ? lineChart(channel2Temp, customMinX2, customMaxX2)
                      : const SizedBox(
                          child: Text(
                          'Нет данных по 2-му каналу, выберите файл',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        )),
                )),
          ),
          // 3 КАНАЛ
          Expanded(
            child: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 0) {
                  setState(() {
                    customMinX3 += 0.01;
                    customMaxX3 += 0.01;
                  });
                } else if (details.delta.dx < 0) {
                  setState(() {
                    customMinX3 -= 0.01;
                    customMaxX3 -= 0.01;
                  });
                }
              },
              onDoubleTap: () {
                setState(() {
                  customMinX3 = 0;
                  customMaxX3 = channel3Temp.length / 250;
                });
              },
              child: SizedBox(
                height: 300,
                child: channel3Temp.isNotEmpty
                    ? lineChart(channel3Temp, customMinX3, customMaxX3)
                    : const SizedBox(
                        child: Text(
                        'Нет данных по 3-му каналу, выберите файл',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// GEsture detector внутрь функции графика, нужно чтобы у каждого был свой скейл