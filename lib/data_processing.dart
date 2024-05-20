

import 'models.dart';


//Read file as string and parse data to 3 channels
List<List<double>> parseData(String fileContent) {
  
  final List<String> data = fileContent.split('\n');

  for (int i = 0; i < data.length; i++) {
    final List<String> dataSample = data[i].split(' ');
    var k = 0;
    for (int i = 0; i < dataSample.length; i++) {
      if (int.tryParse(dataSample[i]) != null) {
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
