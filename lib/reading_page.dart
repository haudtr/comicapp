import 'dart:html';

import 'package:comic_app/detail_comic.dart';
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
  int SelectedUI = 1;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              appBar(),
              const SizedBox(
                height: 5,
              ),
              selectedUIButton(),
              Expanded(child: SelectedUI == 1 ? uiSelection() : uiSelected2()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: changeChapterBar(),
    );
  }

  appBar() {
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

  selectedUIButton() {
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
                SelectedUI = 1;
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
                SelectedUI = 0;
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

  uiSelection() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
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
              child: Column(
                children: [
                  Image.asset("assets/images/image 3.png"),
                  Image.asset("assets/images/image 2.png"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          // DropdownMenuItem(child: child)
        ],
      ),
    );
  }

  uiSelected2() {
    return const SizedBox();
  }

  changeChapterBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      // width: MediaQuery.of(context).size.width / 4,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
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
                child: Text(items),
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
    );
  }
}