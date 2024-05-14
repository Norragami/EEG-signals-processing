import 'models.dart';


//Read file as string and parse data to 3 channels
List<List<int>> parseData(String fileContent) {
  final List<String> data = fileContent.split('\n');

  for (int i = 0; i < data.length; i++) {
    final List<String> dataSample = data[i].split(' ');
    var k = 0;
    for (int i = 0; i < dataSample.length; i++) {
      if (int.tryParse(dataSample[i]) != null) {
        switch (k) {
          case 0:
            {
              channel1.add(int.parse(dataSample[i]));
              k++;
            }

            break;
          case 1:
            {
              channel2.add(int.parse(dataSample[i]));
              k++;
            }
            break;
          case 2:
            {
              channel3.add(int.parse(dataSample[i]));
              k++;
            }
            break;
        }
      }
    }
  }

  return [channel1, channel2, channel3];
}
