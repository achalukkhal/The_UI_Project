import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.deepPurpleAccent, Colors.deepPurple])),
              child: MyHomePage())),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _shakeAnimationController;
  double _shrinkValue = 1.0;
  bool _successState = false;
  Animation<double> _offsetAnimation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _username;
  TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _shakeAnimationSetup();
  }

  @override
  void dispose() {
    super.dispose();
    _shakeAnimationController.dispose();
  }

  void _login() {
    print(_formKey.currentState.validate());
    if (!_formKey.currentState.validate()) {
      setState(() {
        _shakeAnimationController.forward();
      });
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _shrinkValue = 0.0;
          _successState = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: Duration(microseconds: 1),
              child: FlareActor(
                "assets/success.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                // controller: _controls,
                animation: 'go',
                isPaused: !_successState,
              ),
            ),
          ),
        ),
        Positioned.fill(
          // top: MediaQuery.of(context).size.width / 2,
          // left: 40,
          // width: MediaQuery.of(context).size.width - 80.0,
          child: Align(
            alignment: Alignment.center,
            child: TweenAnimationBuilder(
              curve: Curves.easeInOutExpo,
              duration: Duration(milliseconds: 600),
              tween: Tween<double>(begin: 1.0, end: _shrinkValue),
              child: _loginFormWidget(),
              builder: (_, _value, _child) {
                return Transform.scale(
                  scale: _value,
                  child: _child,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginFormWidget() {
    return AnimatedBuilder(
        animation: _shakeAnimationController,
        child: Container(
          width: MediaQuery.of(context).size.width - 80.0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20.0,
              offset: Offset(0, 10),
            )
          ], color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _inputWidget('Username',
                          icon: Icons.person, controller: _username),
                      SizedBox(
                        height: 10,
                      ),
                      _inputWidget('Password',
                          obscureText: true,
                          icon: Icons.lock,
                          controller: _password),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                          elevation: 0.0,
                          color: Colors.deepPurpleAccent,
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _login)
                    ],
                  )),
              FlatButton(
                child: Text('Forgot Password?'),
                onPressed: () {},
              ),
              Text(
                'Copyright 2020, All rights reserved',
                style: TextStyle(fontSize: 10.0),
              )
            ],
          ),
        ),
        builder: (_, _child) {
          return Transform.translate(
            offset: Offset(_offsetAnimation.value, 0.0),
            child: _child,
          );
        });
  }

  /// * @params {Srting} text - placeholder text
  /// * @params {IconData} icon - textfield icon
  /// * @params {TextEditingController} controller
  /// * @params {bool} obscureText

  Widget _inputWidget(String text,
      {@required IconData icon,
      @required TextEditingController controller,
      bool obscureText = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: TextFormField(
        validator: (value) {
          if (value.length < 3)
            return 'Hey, Enter something.';
          else
            return null;
        },
        onSaved: (newValue) {},
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: text,
            prefixIcon: Icon(
              icon,
              color: Colors.black54,
            ),
            focusColor: Colors.black54,
            focusedErrorBorder: OutlineInputBorder(),
            border: OutlineInputBorder(gapPadding: 1.0)),
      ),
    );
  }

  /// AnimationTween Sequence

  void _shakeAnimationSetup() {
    _shakeAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _offsetAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 15.0),
        weight: 40.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 15.0, end: 0.0),
        weight: 40.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: -15.0),
        weight: 40.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -15.0, end: 0.0),
        weight: 40.0,
      ),
    ]).animate(
      CurvedAnimation(
          parent: _shakeAnimationController, curve: Curves.bounceInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _shakeAnimationController.reset();
        }
      });
  }
}
