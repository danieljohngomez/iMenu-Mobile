import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imenu_mobile/main.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen3 extends StatefulWidget {
  @override
  _LoginScreen3State createState() => new _LoginScreen3State();
}

class _LoginScreen3State extends State<LoginScreen3> {
  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpConfirmPasswordController = TextEditingController();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final signUpVisibilityModel = LoadingModel();
  final loginVisibilityModel = LoadingModel();

  @override
  void dispose() {
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

  Widget HomePage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 250.0),
            child: Center(
              child: Icon(
                Icons.fastfood,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "My Restaurant",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
//                Text(
//                  "App",
//                  style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 20.0,
//                      fontWeight: FontWeight.bold),
//                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.redAccent,
                    highlightedBorderColor: Colors.white,
                    onPressed: () => gotoSignup(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => gotoLogin(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget LoginPage() {
    return SingleChildScrollView(
      child: new Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('assets/images/mountains.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(120.0),
              child: Center(
                child: Icon(
                  Icons.fastfood,
                  color: Colors.redAccent,
                  size: 50.0,
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "EMAIL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextField(
                      controller: loginEmailController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'my@email.com',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 24.0,
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextField(
                      controller: loginPasswordController,
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '*********',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 24.0,
            ),
//            new Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(right: 20.0),
//                  child: new FlatButton(
//                    child: new Text(
//                      "Forgot Password?",
//                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        color: Colors.redAccent,
//                        fontSize: 15.0,
//                      ),
//                      textAlign: TextAlign.end,
//                    ),
//                    onPressed: () => {},
//                  ),
//                ),
//              ],
//            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: buildLoginButton(),
                  ),
                ],
              ),
            ),
//            new Container(
//              width: MediaQuery.of(context).size.width,
//              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
//              alignment: Alignment.center,
//              child: Row(
//                children: <Widget>[
//                  new Expanded(
//                    child: new Container(
//                      margin: EdgeInsets.all(8.0),
//                      decoration: BoxDecoration(border: Border.all(width: 0.25)),
//                    ),
//                  ),
////                  Text(
////                    "OR CONNECT WITH",
////                    style: TextStyle(
////                      color: Colors.grey,
////                      fontWeight: FontWeight.bold,
////                    ),
////                  ),
////                  new Expanded(
////                    child: new Container(
////                      margin: EdgeInsets.all(8.0),
////                      decoration: BoxDecoration(border: Border.all(width: 0.25)),
////                    ),
////                  ),
//                ],
//              ),
//            ),
//            new Container(
//              width: MediaQuery.of(context).size.width,
//              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
//              child: new Row(
//                children: <Widget>[
//                  new Expanded(
//                    child: new Container(
//                      margin: EdgeInsets.only(right: 8.0),
//                      alignment: Alignment.center,
//                      child: new Row(
//                        children: <Widget>[
//                          new Expanded(
//                            child: new FlatButton(
//                              shape: new RoundedRectangleBorder(
//                                borderRadius: new BorderRadius.circular(30.0),
//                              ),
//                              color: Color(0Xff3B5998),
//                              onPressed: () => {},
//                              child: new Container(
//                                child: new Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    new Expanded(
//                                      child: new FlatButton(
//                                        onPressed: ()=>{},
//                                        padding: EdgeInsets.only(
//                                          top: 20.0,
//                                          bottom: 20.0,
//                                        ),
//                                        child: new Row(
//                                          mainAxisAlignment:
//                                          MainAxisAlignment.spaceEvenly,
//                                          children: <Widget>[
//                                            Icon(
//                                              const IconData(0xea90,
//                                                  fontFamily: 'icomoon'),
//                                              color: Colors.white,
//                                              size: 15.0,
//                                            ),
//                                            Text(
//                                              "FACEBOOK",
//                                              textAlign: TextAlign.center,
//                                              style: TextStyle(
//                                                  color: Colors.white,
//                                                  fontWeight: FontWeight.bold),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                  new Expanded(
//                    child: new Container(
//                      margin: EdgeInsets.only(left: 8.0),
//                      alignment: Alignment.center,
//                      child: new Row(
//                        children: <Widget>[
//                          new Expanded(
//                            child: new FlatButton(
//                              shape: new RoundedRectangleBorder(
//                                borderRadius: new BorderRadius.circular(30.0),
//                              ),
//                              color: Color(0Xffdb3236),
//                              onPressed: () => {},
//                              child: new Container(
//                                child: new Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    new Expanded(
//                                      child: new FlatButton(
//                                        onPressed: ()=>{},
//                                        padding: EdgeInsets.only(
//                                          top: 20.0,
//                                          bottom: 20.0,
//                                        ),
//                                        child: new Row(
//                                          mainAxisAlignment:
//                                          MainAxisAlignment.spaceEvenly,
//                                          children: <Widget>[
//                                            Icon(
//                                              const IconData(0xea88,
//                                                  fontFamily: 'icomoon'),
//                                              color: Colors.white,
//                                              size: 15.0,
//                                            ),
//                                            Text(
//                                              "GOOGLE",
//                                              textAlign: TextAlign.center,
//                                              style: TextStyle(
//                                                  color: Colors.white,
//                                                  fontWeight: FontWeight.bold),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            )
          ],
        ),
      ),
    );
  }

  Widget SignupPage() {
    return SingleChildScrollView(
      child: new Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('assets/images/mountains.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(100.0),
              child: Center(
                child: Icon(
                  Icons.fastfood,
                  color: Colors.redAccent,
                  size: 50.0,
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "EMAIL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextField(
                      controller: signUpEmailController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'my@email.com',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 24.0,
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextField(
                      controller: signUpPasswordController,
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '*********',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 24.0,
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "CONFIRM PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextField(
                      controller: signUpConfirmPasswordController,
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '*********',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 24.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: new FlatButton(
                    child: new Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    onPressed: () => gotoLogin(animationDuration: 800),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[Expanded(child: buildSignUpButton())],
              ),
            ),
          ],
        ),
      ),
    );
  }

  gotoLogin({int animationDuration = 500}) {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);

    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: _controller,
          physics: new AlwaysScrollableScrollPhysics(),
          children: <Widget>[LoginPage(), HomePage(), SignupPage()],
          scrollDirection: Axis.horizontal,
        ));
  }

    void _doLogin() async {
    String email = loginEmailController.text;
    String password = loginPasswordController.text;

    if (email.isEmpty || password.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill up all fields")));
      return;
    }

    loginVisibilityModel.setLoading(true);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      var app = context.rootAncestorStateOfType(new TypeMatcher<AppState>());
      loginVisibilityModel.setLoading(false);
      app.initState();
    }).catchError((error) {
      var e = error as PlatformException;
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      loginVisibilityModel.setLoading(false);
    }, test: (error) => error is PlatformException);
  }

  void _doSignUp() async {
    String email = signUpEmailController.text;
    String password = signUpPasswordController.text;
    String confirmPassword = signUpConfirmPasswordController.text;
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill up all fields")));
      return;
    } else if (password != confirmPassword) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Password mismatch")));
      return;
    }
    signUpVisibilityModel.setLoading(true);
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Sign up successful")));
      signUpVisibilityModel.setLoading(false);
    }).catchError((error) {
      var e = error as PlatformException;
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      signUpVisibilityModel.setLoading(false);
    }, test: (error) => error is PlatformException);
  }

  Widget buildSignUpButton() {
    return new ScopedModel<LoadingModel>(
      model: signUpVisibilityModel,
      child: ScopedModelDescendant<LoadingModel>(
        builder: (context, widget, model) {
          if (model.loading) return Center(child: CircularProgressIndicator());
          return new FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            color: Colors.redAccent,
            onPressed: () => _doSignUp(),
            child: new Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoginButton() {
    return ScopedModel<LoadingModel>(
      model: loginVisibilityModel,
      child: ScopedModelDescendant<LoadingModel>(
        builder: (context, widget, model) {
          if (model.loading)
            return Center(child: CircularProgressIndicator());

          return new FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            color: Colors.redAccent,
            onPressed: () => _doLogin(),
            child: new Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}

class LoadingModel extends Model {
  bool loading = false;

  void setLoading(bool loading) {
    this.loading = loading;
    notifyListeners();
  }
}
