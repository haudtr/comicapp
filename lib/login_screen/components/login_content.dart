import 'package:comic_app/home_screen_anmie.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:comic_app/login_screen/utils/helper_functions.dart';
import 'package:provider/provider.dart';
import 'package:comic_app/provider/user.dart';

import '../utils/constants.dart';
import '../animations/change_screen_animation.dart';
import 'bottom_text.dart';
import 'top_text.dart';

enum Screens {
  createAccount,
  welcomeBack,
}

var lgEmail, lgPassword;
var userName, email, phoneNumber, password, rePassword;
bool errorPass = false;

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  late final List<Widget> loginContent;
  final _formKey = GlobalKey<FormState>();
  final __formKey = GlobalKey<FormState>();

  late final List<Widget> createAccountContent;

  @override
  void initState() {
    // BuildContext context = null;

    createAccountContent = [
      Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "Username",
            prefixIcon: Icon(Ionicons.person_outline),
          ),
          onSaved: (String? value) {},
          validator: (String? value) {
            if (value!.isEmpty) return "Username is empty!";
            userName = value;
            return null;
          },
        ),
      ),
      const SizedBox(
        height: 3,
      ),
      Consumer<UserProvider>(
        builder: (context, v, child) => Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.7),
              hintText: "Email",
              prefixIcon: Icon(Ionicons.mail_outline),
            ),
            onSaved: (String? value) {},
            validator: (String? value) {
              if (value!.isEmpty)
                return "Email is empty!";
              else if (!v.iSignUp) {
                v.iSignUp = true;
                return "Email already exists!";
              }
              email = value;
              return null;
            },
          ),
        ),
      ),
      const SizedBox(
        height: 3,
      ),
      Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "Phonenumber",
            prefixIcon: Icon(Ionicons.phone_landscape_outline),
          ),
          onSaved: (String? value) {},
          validator: (String? value) {
            if (value!.isEmpty) return "Phonenumber is empty!";
            phoneNumber = value;
            return null;
          },
        ),
      ),
      const SizedBox(
        height: 3,
      ),
      Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "Password",
            prefixIcon: Icon(Ionicons.lock_closed_outline),
          ),
          onSaved: (String? value) {},
          validator: (String? value) {
            if (value!.isEmpty) return "Password is empty!";
            password = value;
            return null;
          },
        ),
      ),
      const SizedBox(
        height: 3,
      ),
      Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "rePassword",
            prefixIcon: Icon(Ionicons.lock_closed_outline),
          ),
          onSaved: (String? value) {},
          validator: (String? value) {
            if (value!.isEmpty)
              return "rePassword is empty!";
            else if (password != value)
              return "rePassword and password don't match!";
            rePassword = value;
            return null;
          },
        ),
      ),
      const SizedBox(
        height: 3,
      ),
      Consumer<UserProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
          child: ElevatedButton(
            onPressed: () {
              if (__formKey.currentState!.validate()) {
                // setState(() {
                (() async {
                  value.iSignUp = true;

                  await value.signUpAccount(
                      userName, email, phoneNumber, password);
                  // setState(() {
                  if (value.iSignUp) {
                    value.getUser(email);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeComic(),
                      ),
                    );
                  }
                  // });
                })();
                // });
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: const StadiumBorder(),
              primary: kSecondaryColor,
              elevation: 8,
              shadowColor: Colors.black87,
            ),
            child: const Text(
              "Register",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ];
    loginContent = [
      Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "Email",
            prefixIcon: Icon(Ionicons.mail_outline),
          ),
          onSaved: (String? value) {},
          validator: (String? value) {
            if (value!.isEmpty) return "Email is empty!";
            lgEmail = value;
            return null;
          },
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Consumer<UserProvider>(
        builder: (context, v, child) => Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: TextFormField(
            obscureText: true,
            enableSuggestions: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.7),
              hintText: "Password",
              prefixIcon: Icon(Ionicons.lock_closed_outline),
            ),
            onSaved: (String? value) {},
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Password is empty!";
              } else if (errorPass) {
                errorPass = false;
                return "Email or password is incorrect!";
              }
              lgPassword = value;
              return null;
            },
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextButton(
          onPressed: () {},
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kSecondaryColor,
            ),
          ),
        ),
      ),
      Consumer<UserProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                if (_formKey.currentState!.validate()) {
                  (() async {
                    await value.loginAccount(lgEmail, lgPassword);
                    if (value.iLogIn) {
                      value.getUser(lgEmail);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        // do something
                        return HomeComic();
                      }));
                    }
                    errorPass = true;
                  })();
                }
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: const StadiumBorder(),
              primary: kSecondaryColor,
              elevation: 8,
              shadowColor: Colors.black87,
            ),
            child: const Text(
              "Login",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ];
    ChangeScreenAnimation.initialize(
      vsync: this,
      loginItems: loginContent.length,
      createAccountItems: createAccountContent.length,
    );

    for (var i = 0; i < createAccountContent.length; i++) {
      createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.createAccountAnimations[i],
        child: createAccountContent[i],
      );
    }
    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.loginAnimations[i],
        child: loginContent[i],
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    ChangeScreenAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var account = Provider.of<UserProvider>(context);

    return Stack(
      children: [
        const Positioned(
          top: 136,
          left: 24,
          child: TopText(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Form(
                  key: __formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: createAccountContent,
                  )),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: loginContent,
                ),
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: BottomText(),
          ),
        ),
      ],
    );
  }
}
