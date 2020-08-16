import 'package:flutter/cupertino.dart';

class AirportInfo {
  final String airportCode;
  final String airportName;
  final String time;

  AirportInfo({this.airportCode, this.airportName, this.time});
}

class FlightInfo {
  final String label;
  final String info;

  FlightInfo({this.label, this.info});
}

class CardData {
  final Key key;
  final Color color;
  final Color shadowColor;
  final AirportInfo destination;
  final AirportInfo source;
  final List<FlightInfo> otherInfo;

  CardData(
      {this.key,
      this.color,
      this.shadowColor,
      this.destination,
      this.source,
      this.otherInfo});
}

const TAG_QR_CODE = 'qr_code';
const TAG_CARD_INFORMATION = 'card_info';
