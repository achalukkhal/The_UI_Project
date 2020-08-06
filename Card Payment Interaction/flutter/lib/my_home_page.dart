import 'package:flutter/material.dart';

import 'data.dart';
import 'payment_card_holder.dart';
import 'dart:math' as math;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool displayLoading = false;
  bool displayVerificationCode = false;
  String _vCode = '';
  final _pageController = PageController(initialPage: 0);

  @override
  initState() {
    super.initState();
    _pageController.addListener(() {
      if (displayVerificationCode || displayLoading) {
        if (displayLoading) displayLoading = false;
        if (displayVerificationCode) displayVerificationCode = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _startLoading() {
    setState(() {
      displayLoading = true;
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        displayLoading = false;
        displayVerificationCode = true;
        _vCode = (math.Random().nextInt(900) + 100).toString() +
            '-' +
            (math.Random().nextInt(900) + 100).toString();
      });
    });
    // _pageController.detach(_pageController.page)
  }

  void _rest() {
    setState(() {
      displayLoading = false;
      displayVerificationCode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Pull to Pay',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Quick and easy way to make payments. \n Zero hassle',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        _backgroundTextWidget(),
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.transparent,
                          child: PageView.builder(
                              controller: _pageController,
                              itemCount: cardData.length,
                              itemBuilder: (context, index) {
                                return PaymentCardHolder(
                                    card: cardData[index],
                                    onSwipDownComplete: _startLoading,
                                    onRest: _rest);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.nfc, color: Colors.white),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Scan for payment and pull down to confirm. \nOr Pull down to get verification code.',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _backgroundTextWidget() {
    return Positioned.fill(
        top: 0,
        left: 0,
        // width: double.maxFinite,
        child: displayLoading
            ? _loadingWidget()
            : displayVerificationCode ? _verificationCode() : Container());
  }

  Widget _loadingWidget() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Text(
          'Please Wait...',
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontStyle: FontStyle.italic),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: LinearProgressIndicator(),
        )
      ],
    );
  }

  Widget _verificationCode() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Text(
          'Your Payment Code ',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          _vCode,
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
