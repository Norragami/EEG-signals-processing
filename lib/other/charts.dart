import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget lineChart(List<double> channel, double customMinX, double customMaxX) {
  return Padding(
    padding: const EdgeInsets.all(26.0),
    child: LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blue.shade400,
          getTooltipItems: (touchedSpots) {
            return touchedSpots
                .map((spot) => LineTooltipItem(
                    '${spot.y.toStringAsFixed(2)} мкВ \n ${spot.x.toStringAsFixed(2)} с',
                    const TextStyle()))
                .toList();
          },
        )),

        clipData: const FlClipData.all(),

        minX: customMinX,
        maxX: customMaxX,
        // minY: -100 - channel.reduce(min).toDouble()>-50? -100:-50,
        // maxY: 100 - channel.reduce(max).toDouble()<50? 100:50,

        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < channel.length; i++)
                FlSpot(i.toDouble() / 250, channel[i])
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
                  reservedSize: 50,
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
