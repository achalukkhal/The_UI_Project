import 'package:flutter/material.dart';
import 'card_full_view.dart';
import 'custom_border.dart';
import 'models.dart';

class CardWidget extends StatefulWidget {
  final CardData cardData;
  CardWidget({Key key, this.cardData}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final Duration _duration = Duration(milliseconds: 180);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        lowerBound: 0.0, upperBound: 0.05, vsync: this, duration: _duration);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _onTapCardAction() {
    Future.delayed(_duration, () {
      setState(() {
        _animationController.reverse();
      });
    });
    Future.delayed(
      _duration + Duration(milliseconds: 200),
      () => Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => CardFullView(
            cardData: widget.cardData,
          ),
        ),
      ),
    );
    setState(() {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapCardAction,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _child) {
          return Transform.scale(
            scale: 1.0 + _animationController.value,
            child: _child,
          );
        },
        child: _widgetBoardingCard(widget.cardData),
      ),
    );
  }

  Widget _widgetFlightInfo(AirportInfo airportInfo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        Text(
          airportInfo?.airportCode,
          style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
        ),
        Text(
          airportInfo?.airportName,
          style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          airportInfo?.time,
          style: TextStyle(
              fontSize: 12,
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
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          _cardShadow(cardData.shadowColor),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: cardData.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Hero(
                    tag: '${TAG_CARD_INFORMATION}_${cardData.key}',
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
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
                SizedBox(
                  width: 30,
                ),
                AnimatedBuilder(
                    animation: _animationController,
                    child: Hero(
                      tag: '${TAG_QR_CODE}_${cardData.key}',
                      child:
                      ClipRRect(
                        child: Stack(
                          fit: StackFit.loose,
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                                top: -4,
                                left: -4,
                                child: CustomPaint(
                                    painter:
                                    CustomBorder( width: 80, height: 80, backgroundColor: cardData.color))),
                            SizedBox(
                              width: 75,
                              height: 75,
                              child: Image.asset(
                                'assets/qr-code.png',
                                scale: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    builder: (context, _child) {
                      return Transform.scale(
                        scale: 1.0 + (_animationController.value * 2.0),
                        child: _child,
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardShadow(Color color) {
    return Positioned.fill(
      left: 0,
      bottom: -20,
      child: Transform.scale(
        scale: 0.90,
        child: Opacity(
          opacity: 0.5,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: color, blurRadius: 15.0, spreadRadius: 8)
              ],
              borderRadius: BorderRadius.circular(150),
            ),
          ),
        ),
      ),
    );
  }
}
