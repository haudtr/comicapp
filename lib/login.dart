import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Image.asset("assets/images/image 6.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 8),
                              hintText: "Email",
                            ),
                            onSaved: (String? value) {},
                            validator: (String? value) {
                              if (value!.isEmpty)
                                return "Vui long nhap email";
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(),
                          ),
                          child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 8),
                                hintText: "Mat khau",
                              ),
                              onSaved: (String? value) {},
                              validator: (String? value) {
                                if (value!.isEmpty) ;
                                return "Vui long nhap mat khau";
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Quên mật khẩu ?",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            //on tap code here, you can navigate to other page or URL
                                          }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14)),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState!.validate()){}
                              });
                            },
                            child: Text(
                              "Đăng nhập",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Divider(
                                  color: Colors.black,
                                  thickness: 0.8,
                                )
                              ],
                            ),
                          ),
                          const Text(
                            "Hoặc đăng nhập bằng cách",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Divider(
                                  color: Colors.black,
                                  thickness: 0.8,
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Stack(children: [
                      Positioned(
                          width: 60,
                          height: 60,
                          left: 10,
                          child: Image.asset("assets/images/google.png")),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(14),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Text(
                          "Google",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                    ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Stack(children: [
                      Positioned(
                          width: 60,
                          height: 60,
                          left: 10,
                          child: Image.asset("assets/images/Vector.png")),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(14),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Text(
                          "Facebook",
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              style:  TextStyle(
                                fontSize: 18
                              ),
                              text: "Bạn chưa có tài khoản?"),
                            TextSpan(
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 18
                              ),
                              text: " Đăng ký",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  //on tap code here, you can navigate to other page or URL
                                },
                            ),
                            const TextSpan(
                              style:  TextStyle(
                                fontSize: 18
                              ),
                              text: " ở đây"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
