import 'package:flutter/material.dart';

import 'payment_card_model.dart';

class PaymentCard extends StatelessWidget {
  final PaymentCardModel paymentCardModel;
  const PaymentCard({Key key, this.paymentCardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.white38,
                  offset: Offset(0.0, 10.0),
                  blurRadius: 15.0)
            ],
            gradient: LinearGradient(
                colors: paymentCardModel.cardColors,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: RotatedBox(
          quarterTurns: -1,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      paymentCardModel.cardName.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'BANK NAME',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        paymentCardModel.nameOnCard.toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(paymentCardModel.cardNo,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              shadows: [
                                Shadow(
                                    color: Colors.black87,
                                    blurRadius: 1.0,
                                    offset: Offset(1.0, 0.0))
                              ])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('Expiry Date: ${paymentCardModel.expiryDate}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            _merchantImage(paymentCardModel.merchentType),
                            width: 80,
                          ),
                        ],
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _merchantImage(MerchentType mId) {
    switch (mId) {
      case MerchentType.MASTER:
        return 'assets/mc_icon.png';
      case MerchentType.AMERICAN_EXPRESS:
        return 'assets/am_icon.png';
      case MerchentType.VISA:
        return 'assets/v_icon.png';
      default:
        return 'assets/mc_icon.png';
    }
  }
}
