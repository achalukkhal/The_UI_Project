import 'package:flutter/material.dart';
import 'payment_card_model.dart';
import 'payment_card.dart';

class PaymentCardHolder extends StatefulWidget {
  final PaymentCardModel card;
  final Function onSwipDownComplete;
  final Function onRest;
  PaymentCardHolder({Key key, this.card, this.onSwipDownComplete, this.onRest})
      : super(key: key);

  @override
  _PaymentCardHolderState createState() => _PaymentCardHolderState();
}

class _PaymentCardHolderState extends State<PaymentCardHolder> {
  bool isLoading = false;
  double _delta = 0.0;
  double _startPos;
  double _deviceWidth;
  double _deviceHeight;
  double _cardHeight;
  double _cardWidth;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    _cardHeight = _deviceWidth * 1.40;
    _cardWidth = _deviceWidth - 20;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        AnimatedPositioned(
          duration: Duration(milliseconds: 950),
          curve: Curves.linearToEaseOut,
          left: 0,
          top: _delta,
          height: _cardHeight,
          width: _cardWidth,
          onEnd: () {
            if (_delta == 0) widget.onRest();
          },
          child: GestureDetector(
            onVerticalDragEnd: (_) {
              if (!isLoading) {
                setState(() {
                  _delta = 0.0;
                });
              }
            },
            onVerticalDragStart: (_) {
              _startPos = _.localPosition.dy;
            },
            onVerticalDragUpdate: (_) {
              if (!isLoading) {
                _delta = _.localPosition.dy - _startPos;
                int deltaPercentage = (_delta / _deviceHeight * 100).floor();
                if (_delta > 0 && deltaPercentage < 15) {
                  setState(() {
                    _delta = _delta.abs();
                  });
                }
                if (deltaPercentage > 15 && !isLoading) {
                  isLoading = true;
                  widget.onSwipDownComplete();
                }
              }
            },
            onDoubleTap: () {
              setState(() {
                _delta = 0.0;
                isLoading = false;
              });
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PaymentCard(paymentCardModel: widget.card),
            ),
          ),
        ),
      ],
    );
  }
}
