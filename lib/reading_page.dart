import 'dart:ui';

import 'package:flutter/material.dart';

class ReadingPageScreen extends StatefulWidget {
  const ReadingPageScreen({super.key});

  @override
  State<ReadingPageScreen> createState() => _ReadingPageScreenState();
}

const double width = 200;
const double height = 40;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class _ReadingPageScreenState extends State<ReadingPageScreen> {
  late double xAlign;
  late Color loginColor;
  late Color signInColor;
  int selectedUI = 1;
  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  bool chatSelected = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                const SizedBox(
                  height: 5,
                ),
                _buildSelectedUIButton(context),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: selectedUI == 1
                        ? _buildClassicUI(context)
                        : _buildSlideUI(context)),
              ],
            ),
          ),
          _commentPopUp(context),
        ],
      ),
      bottomNavigationBar: _buildChangeChapterBar(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          const Text(
            "Jujutsu Kaisen",
            style: TextStyle(fontSize: 20),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
    );
  }

  Widget _buildSelectedUIButton(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: width * 0.5,
              height: height,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = loginAlign;
                loginColor = selectedColor;

                signInColor = normalColor;
                selectedUI = 1;
              });
            },
            child: Align(
              alignment: const Alignment(-1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'Classic UI',
                  style: TextStyle(
                    color: loginColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = signInAlign;
                signInColor = selectedColor;

                loginColor = normalColor;
                selectedUI = 0;
              });
            },
            child: Align(
              alignment: const Alignment(1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'Slide UI',
                  style: TextStyle(
                    color: signInColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassicUI(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Chuong 3: Ac mong",
          style: TextStyle(fontSize: 22),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/image 3.png",
                      fit: BoxFit.fill,
                    ),
                    Image.asset(
                      "assets/images/image 3.png",
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        // DropdownMenuItem(child: child)
      ],
    );
  }

  Widget _buildSlideUI(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Chuong 3: Ac mong",
          style: TextStyle(fontSize: 22),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Image.asset(
                    "assets/images/image 3.png",
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/images/image 3.png",
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget _buildChangeChapterBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              chatSelected = !chatSelected;
            });
          },
          icon: const Icon(Icons.chat),
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  iconSize: 30,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: const Icon(Icons.navigate_before)),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              alignment: Alignment.topCenter,
                              borderRadius: BorderRadius.circular(10),
                              iconSize: 0.0,
                              icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward),
                              ),
                              value: dropdownvalue,
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Center(child: Text(items)),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  iconSize: 30,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: const Icon(Icons.navigate_next)),
            ],
          ),
        ),
        IconButton(
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            // style: IconButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {},
            icon: const Icon(Icons.arrow_upward)),
      ],
    );
  }

  Widget _testComment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color.fromARGB(255, 33, 44, 51),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Huy",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _testDayComment(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24),
      child: Text(
        "4 ngay truoc",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _commentPopUp(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 14,
          bottom: 16,
        ),
        child: AnimatedAlign(
          curve: Curves.fastOutSlowIn,
          alignment: chatSelected ? Alignment.topLeft : Alignment.bottomLeft,
          duration: const Duration(seconds: 2),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 54, 69, 79),
              borderRadius: BorderRadius.circular(20),
            ),
            width:
                chatSelected ? MediaQuery.of(context).size.width * (9 / 10) : 0,
            height: chatSelected
                ? MediaQuery.of(context).size.height * (7 / 10)
                : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  width: double.infinity,
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Binh luan",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _testComment(context),
                          const SizedBox(
                            height: 5,
                          ),
                          _testDayComment(context),
                          _testComment(context),
                          const SizedBox(
                            height: 5,
                          ),
                          _testDayComment(context),
                          _testComment(context),
                          const SizedBox(
                            height: 5,
                          ),
                          _testDayComment(context),
                          _testComment(context),
                          const SizedBox(
                            height: 5,
                          ),
                          _testDayComment(context),
                        ],
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: 45,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 54, 52, 55),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Huy",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) ;
                                    },
                                    child: const Text(
                                      "GUI",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Color.fromARGB(255, 42, 69, 87),
                            ),
                            child: TextFormField(
                              initialValue: "Nhap binh luan...",
                              style: const TextStyle(color: Colors.white),
                              // decoration: const InputDecoration(
                              //   contentPadding: EdgeInsets.only(left: 14),
                              //   hintText: "Nhap binh luan",
                              // ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nhap binh luan';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
