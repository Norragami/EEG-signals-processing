import 'dart:io';
import 'dart:math';

import 'package:eeg_processing/other/filters.dart';
import 'package:file_picker/file_picker.dart';

import 'models.dart';

//Read file as string and parse data to 3 channels
List<List<double>> parseData(String fileContent) {
  final List<String> data = fileContent.split('\n');
  channel1 = [];
  channel2 = [];
  channel3 = [];
  for (int i = 0; i < data.length; i++) {
    final List<String> dataSample = data[i].split(' ');
    var k = 0;
    for (int i = 0; i < dataSample.length; i++) {
      if (double.tryParse(dataSample[i]) != null) {
        switch (k) {
          case 0:
            {
              channel1.add(double.parse(dataSample[i]));
              k++;
            }

            break;
          case 1:
            {
              channel2.add(double.parse(dataSample[i]));
              k++;
            }
            break;
          case 2:
            {
              channel3.add(double.parse(dataSample[i]));
              k++;
            }
            break;
        }
      }
    }
  }

  channel1Temp = channel1;
  channel2Temp = channel2;
  channel3Temp = channel3;

  return [channel1, channel2, channel3];
}

List<double> calculateStat(List<double> channel) {
  var mean = channel.reduce((a, b) => a + b) / channel.length;
  
  List<double> dev = List<double>.filled(channel.length, 0);
  for (int i = 0; i < channel.length; i++) {
    dev[i] = (channel[i] - mean);
  }
  var devTemp = dev.map((e) => e.abs()).toList();
  var devTemp2 = dev.reduce((a, b) => a + b);
  md = devTemp2 / dev.length;

  maxD = devTemp.reduce(max);

  devTemp = dev.map((e) => e * e).toList();
  sd = sqrt(devTemp.reduce((a, b) => a + b) / dev.length);

  variation = sd * sd;
  return [md, maxD, sd, variation];
}

void saveData(channel1, channel2, channel3) async {
  var originCh1Filtered =
      Detrend.detrend(Filter50Hz.filter(LowPassFilter.filter(channel1)));
  var originCh2Filtered =
      Detrend.detrend(Filter50Hz.filter(LowPassFilter.filter(channel2)));
  var originCh3Filtered =
      Detrend.detrend(Filter50Hz.filter(LowPassFilter.filter(channel3)));

  var betaCh1 = BandPassFilter.filter(LowPassFilter.filter(channel1));
  var betaCh2 = BandPassFilter.filter(LowPassFilter.filter(channel2));
  var betaCh3 = BandPassFilter.filter(LowPassFilter.filter(channel3));

  String? path = await FilePicker.platform.getDirectoryPath();

  if (path != null) {
    var filtered = writeData(originCh1Filtered,originCh2Filtered,originCh3Filtered);
    var betaFiltered = writeData(betaCh1,betaCh2,betaCh3);
    var origin = writeData(channel1, channel2, channel3);

    File('$path/EEG_3c_04_f.txt').writeAsString(filtered);
    File('$path/EEG_3c_04_beta.txt').writeAsString(betaFiltered);
    File('$path/EEG_3c_04_i.txt').writeAsString(origin);
  }
}



String writeData (ch1Filtered,ch2Filtered,ch3Filtered){
  var filtered = '';
    for (int i = 0; i < channel1.length; i++) {
      var value1 = ch1Filtered[i] >= 0
          ? '   ${ch1Filtered[i].toStringAsFixed(2)}'
          : '  ${ch1Filtered[i].toStringAsFixed(2)}';
      var value2 = ch2Filtered[i] >= 0
          ? '   ${ch2Filtered[i].toStringAsFixed(2)}'
          : '  ${ch2Filtered[i].toStringAsFixed(2)}';
      var value3 = ch3Filtered[i] >= 0
          ? '   ${ch3Filtered[i].toStringAsFixed(2)}'
          : '  ${ch3Filtered[i].toStringAsFixed(2)}';
      filtered += '$value1$value2$value3\n';
    }

  return filtered;
}