import 'package:eeg_processing/other/filters.dart';
import 'package:flutter/material.dart';

import '../other/data_processing.dart';

List<DataRow> setRows(channel1, channel2, channel3) {
  var originCh1Stats = calculateStat(
      Detrend.detrend(Filter50Hz.filter(LowPassFilter.filter(channel1))));
  var originCh2Stats = calculateStat(
      Detrend.detrend(Filter50Hz.filter(LowPassFilter.filter(channel2))));
  var originCh3Stats = calculateStat(
      Detrend.detrend(Filter50Hz.filter(LowPassFilter.filter(channel3))));

  var betaCh1Stats =
      calculateStat(BandPassFilter.filter(LowPassFilter.filter(channel1)));
  var betaCh2Stats =
      calculateStat(BandPassFilter.filter(LowPassFilter.filter(channel2)));
  var betaCh3Stats =
      calculateStat(BandPassFilter.filter(LowPassFilter.filter(channel3)));
      
  return [
    DataRow(cells: [
      const DataCell(Text('MD')),
      DataCell(Text(
          '${originCh1Stats[0].toStringAsExponential(3)}  /  ${betaCh1Stats[0].toStringAsExponential(3)}')),
      DataCell(Text(
          '${originCh2Stats[0].toStringAsExponential(3)}  /  ${betaCh2Stats[0].toStringAsExponential(3)}')),
      DataCell(Text(
          '${originCh3Stats[0].toStringAsExponential(3)}  /  ${betaCh3Stats[0].toStringAsExponential(3)}')),
    ]),
    DataRow(
      cells: [
        const DataCell(Text('MaxD')),
        DataCell(Text(
            '${originCh1Stats[1].toStringAsFixed(3)}  /  ${betaCh1Stats[1].toStringAsFixed(3)}')),
        DataCell(Text(
            '${originCh2Stats[1].toStringAsFixed(3)}  /  ${betaCh2Stats[1].toStringAsFixed(3)}')),
        DataCell(Text(
            '${originCh3Stats[1].toStringAsFixed(3)}  /  ${betaCh3Stats[1].toStringAsFixed(3)}')),
      ],
    ),
    DataRow(cells: [
      const DataCell(Text('SD')),
      DataCell(Text(
          '${originCh1Stats[2].toStringAsFixed(3)}  /  ${betaCh1Stats[2].toStringAsFixed(3)}')),
      DataCell(Text(
          '${originCh2Stats[2].toStringAsFixed(3)}  /  ${betaCh2Stats[2].toStringAsFixed(3)}')),
      DataCell(Text(
          '${originCh3Stats[2].toStringAsFixed(3)}  /  ${betaCh3Stats[2].toStringAsFixed(3)}')),
    ]),
    DataRow(cells: [
      const DataCell(Text('Var')),
      DataCell(Text(
          '${originCh1Stats[3].toStringAsFixed(3)}  /  ${betaCh1Stats[3].toStringAsFixed(3)}')),
      DataCell(Text(
          '${originCh2Stats[3].toStringAsFixed(3)}  /  ${betaCh2Stats[3].toStringAsFixed(3)}')),
      DataCell(Text(
          '${originCh3Stats[3].toStringAsFixed(3)}  /  ${betaCh3Stats[3].toStringAsFixed(3)}')),
    ]),
  ];
}
