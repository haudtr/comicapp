import 'package:comic_app/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildLogo(context),
            _signInForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Image.asset("assets/images/image 6.png");
  }

  Widget _signInForm(BuildContext context) {
    return Padding(
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
                  hintText: "Ten tai khoan",
                ),
                onSaved: (String? value) {},
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Vui long nhap ten tai khoan";
                  }
                  return null;
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
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8),
                  hintText: "Email",
                ),
                onSaved: (String? value) {},
                validator: (String? value) {
                  if (value!.isEmpty) return "Vui long nhap email";
                  return null;
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
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8),
                  hintText: "So dien thoai",
                ),
                onSaved: (String? value) {},
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Vui long nhap so dien thoai";
                  }
                  return null;
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
                    hintText: "Password",
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Vui long nhap mat khau";
                    }
                    return null;
                  }),
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
                    hintText: "Nhap lai mat khau",
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Vui long nhap mat khau";
                    }
                    return null;
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(12),
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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(14)),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () {
                  setState(() {
                    if (_formKey.currentState!.validate()) {}
                  });
                },
                child: const Text(
                  "Đăng ký",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
