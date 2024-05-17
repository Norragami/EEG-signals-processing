import 'dart:math';

import 'package:eeg_processing/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget lineChart(List<int> channel, double minX, double maxX) {
  return Padding(
    padding: const EdgeInsets.all(26.0),
    child: LineChart(
      LineChartData(
        
        clipData: FlClipData.all(),
        minX: customMinX,
        maxX: customMaxX,
        minY: -100 - channel.reduce(min).toDouble()>-50? -100:-50,
        maxY: 100 - channel.reduce(max).toDouble()<50? 100:50,
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < channel.length; i++)
                FlSpot(i.toDouble() / 250, channel[i].toDouble()),
            ],
            dotData: const FlDotData(show: false),
          )
        ],
        titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
                axisNameWidget: Text(
                  "Амплитуда,мкВ",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                axisNameSize: 30,
                sideTitles: SideTitles(
                  
                  showTitles: true,
                  reservedSize: 40,
                )),
            bottomTitles: AxisTitles(
                axisNameWidget: Text(
                  "Время,с",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                axisNameSize: 30,
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                )),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            )),
      ),
    ),
  );
}
