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
              SizedBox(
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
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_horiz))
                  ],
                ),
              ),
              // ToggleButtons(
              //   borderRadius: BorderRadius.circular(10),
              //   selectedColor: Colors.white,
              //   fillColor: Colors.grey,
              //   isSelected: _isSelected,
              //   onPressed: (int index) {
              //     setState(() {
              //       for (int i = 0; i < _isSelected.length; i++) {
              //         _isSelected[i] = i == index;
              //       }
              //     });
              //   },
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: SizedBox(
              //           width: MediaQuery.of(context).size.width / 5,
              //           child: const Center(
              //               child: Text(
              //             "Classic UI",
              //             style: TextStyle(fontSize: 16),
              //           ))),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: SizedBox(
              //           width: MediaQuery.of(context).size.width / 5,
              //           child: const Center(
              //               child: Text(
              //             "Slide UI",
              //             style: TextStyle(fontSize: 16),
              //           ))),
              //     ),
              //   ],
              // ),
              Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
