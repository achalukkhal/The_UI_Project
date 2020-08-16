import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'custom_border.dart';
import 'models.dart';

class CardFullView extends StatefulWidget {
  final CardData cardData;
  CardFullView({Key key, this.cardData}) : super(key: key);

  @override
  _CardFullViewState createState() => _CardFullViewState();
}

class _CardFullViewState extends State<CardFullView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 0.0,
        backgroundColor: widget.cardData.color,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: widget.cardData.color,
        ),
        child: _widgetBoardingCard(widget.cardData),
      ),
    );
  }

  Widget _widgetFlightInfo(AirportInfo airportInfo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          airportInfo?.airportCode,
          style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
        ),
        Text(
          airportInfo?.airportName,
          style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          airportInfo?.time,
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
        ),
      ],
    );
  }

  Widget _widgetFlightSubInfo(FlightInfo flightInfo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          flightInfo?.label,
          style: TextStyle(
              fontSize: 11,
              color: Colors.white,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          flightInfo?.info,
          style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none),
        ),
      ],
    );
  }

  Widget _widgetBoardingCard(CardData cardData) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Hero(
            tag: '${TAG_CARD_INFORMATION}_${cardData.key}',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _widgetFlightInfo(cardData.source),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.airplanemode_active,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      _widgetFlightInfo(cardData.destination)
                    ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: 2,
                    child: Container(
                      color: Colors.white54,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: cardData.otherInfo
                      .map((e) => _widgetFlightSubInfo(e))
                      .toList(),
                )
              ]),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Hero(
            tag: '${TAG_QR_CODE}_${cardData.key}',
            child: ClipPath(
              clipper: QrCodeClipper(),
              child: Stack(
                fit: StackFit.loose,
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                      top: -25,
                      left: -20,
                      child: CustomPaint(
                          painter:
                          CustomBorder(backgroundColor: cardData.color))),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      'assets/qr-code.png',
                      scale: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: null,
          ),
        )
      ],
    );
  }
}


class QrCodeClipper  extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()..addRect(Rect.fromLTWH(-30, -30, 220, 220));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}