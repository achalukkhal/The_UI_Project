import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'models.dart';

final data = [
  CardData(
      key: Key('SXF-LHR'),
      color: Colors.deepPurpleAccent,
      shadowColor: Colors.deepPurple,
      source: AirportInfo(
          airportCode: 'SXF', airportName: 'New York', time: '07:00'),
      destination:
          AirportInfo(airportCode: 'LHR', airportName: 'London', time: '15:00'),
      otherInfo: [
        FlightInfo(label: 'Terminal', info: 'T2'),
        FlightInfo(label: 'Gate', info: '05'),
        FlightInfo(label: 'Boarding', info: '14:30')
      ]),
  CardData(
      key: Key('BOM-DXB'),
      color: Colors.blue,
      shadowColor: Colors.blueAccent,
      source:
          AirportInfo(airportCode: 'BOM', airportName: 'Bombay', time: '12:30'),
      destination:
          AirportInfo(airportCode: 'DXB', airportName: 'Dubai', time: '16:20'),
      otherInfo: [
        FlightInfo(label: 'Terminal', info: 'T1'),
        FlightInfo(label: 'Gate', info: '11'),
        FlightInfo(label: 'Boarding', info: '11:30')
      ]),
  CardData(
      key: Key('DEL-LHR'),
      color: Colors.deepOrangeAccent,
      shadowColor: Colors.deepOrange,
      source: AirportInfo(
          airportCode: 'DEL', airportName: 'New Delhi', time: '07:00'),
      destination:
          AirportInfo(airportCode: 'LHR', airportName: 'London', time: '22:00'),
      otherInfo: [
        FlightInfo(label: 'Terminal', info: 'T3'),
        FlightInfo(label: 'Gate', info: '67'),
        FlightInfo(label: 'Boarding', info: '14:30')
      ])
];
