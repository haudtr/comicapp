import 'package:comic_app/models/chapter.dart';
import 'package:comic_app/provider/commentProvider.dart';
import 'package:flutter/material.dart';
import 'package:comic_app/constants/constant.dart' as constant;
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';

class ReadingPageScreen extends StatefulWidget {
  ChapterModel item;

  ReadingPageScreen({super.key, required this.item});

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
  final commentController = TextEditingController();
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

  bool iLoading = true;
  bool chatSelected = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var commentProvider = Provider.of<CommentProvider>(context);
    var cmt;
    if (iLoading) {
      (() async {
        await commentProvider.getCommentComic(widget.item.id);
        setState(() {
          iLoading = false;
        });
      })();
    }
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
          Positioned(
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 14,
                bottom: 16,
              ),
              child: AnimatedAlign(
                curve: Curves.fastOutSlowIn,
                alignment:
                    chatSelected ? Alignment.topLeft : Alignment.bottomLeft,
                duration: const Duration(seconds: 2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 24, 50, 71),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: chatSelected
                      ? MediaQuery.of(context).size.width * (9 / 10)
                      : 0,
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
                            "Bình luận",
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
                            child: iLoading
                                ? Center(
                                    child: LoadingAnimationWidget.dotsTriangle(
                                    color: Colors.blueGrey,
                                    size: 50,
                                  ))
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...commentProvider.listComicComment.map(
                                          (e) => _testComment(
                                              context,
                                              e.tenDocGia,
                                              e.noiDung,
                                              e.ngayBinhLuan))

                                      // _testComment(context),
                                      // const SizedBox(
                                      //   height: 5,
                                      // ),
                                      // _testDayComment(context),
                                      // _testComment(context),
                                      // const SizedBox(
                                      //   height: 5,
                                      // ),
                                      // _testDayComment(context),
                                      // _testComment(context),
                                      // const SizedBox(
                                      //   height: 5,
                                      // ),
                                      // _testDayComment(context),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 49, 49, 49),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      constant.user!.tenUser,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            (() async {
                                              await commentProvider
                                                  .commentChapter(
                                                      constant.user!.id,
                                                      constant.user!.tenUser,
                                                      widget.item.id,
                                                      commentController.text);
                                              commentProvider.getCommentComic(
                                                  widget.item.id);
                                            })();
                                            commentController.clear();
                                          }
                                        },
                                        child: const Text(
                                          "Gửi",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                controller: commentController,
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(fontSize: 17),
                                    hintText: 'Nhập bình luận...',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 5,
                                        right: 10,
                                        bottom: 15)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
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
          BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            widget.item.tenTruyen,
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
        Text(
          "Chương " + widget.item.tapSo.toString() + ": " + widget.item.ten,
          style: TextStyle(fontSize: 22),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              ...widget.item.noiDung.map((e) => Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Image.network(
                        e.anh,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        )

        // DropdownMenuItem(child: child)
      ],
    );
  }

  Widget _buildSlideUI(BuildContext context) {
    return const SizedBox();
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
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(14)),
            color: Colors.grey,
          ),
          child: IconButton(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              style: IconButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {},
              icon: const Icon(Icons.arrow_upward)),
        ),
      ],
    );
  }

  Widget _testComment(
      BuildContext context, String tenUser, String noiDung, DateTime date) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color.fromARGB(255, 1, 26, 46),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tenUser,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  noiDung,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          buildDateFormat(date),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  // Widget _testDayComment(BuildContext context) {
  //   return const Padding(
  //     padding: EdgeInsets.only(left: 24),
  //     child: Text(
  //       "4 ngay truoc",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   );
  // }
  Widget buildDateFormat(DateTime createDate) {
    return Text(
      // 86400
      daysBetween(createDate, DateTime.now()) < 60
          ?
          //Nếu dưới 60 giây
          "${daysBetween(createDate, DateTime.now())} seconds ago"
          :
          // Trên 60 giây, đổi sang phút
          (daysBetween(createDate, DateTime.now()) / 60).round() < 60
              ?
              //Dưới 60 phút
              "${(daysBetween(createDate, DateTime.now()) / 60).round()} minutes ago"
              :
              //Trên 60 phút, đổi sang giờ
              (daysBetween(createDate, DateTime.now()) / (60 * 60)).round() < 24
                  ?
                  //Dưới 24 giờ
                  "${(daysBetween(createDate, DateTime.now()) / (60 * 60)).round()} hours ago"
                  :
                  //Trên 24 giờ, đổi sang ngày
                  (daysBetween(createDate, DateTime.now()) / (24 * 60 * 60))
                              .round() <
                          7
                      ?
                      //Dưới 7 ngày
                      "${(daysBetween(createDate, DateTime.now()) / (24 * 60 * 60)).round()} days ago"
                      :
                      //Trên 7 ngày
                      DateFormat('dd-MM-yy').format(createDate),
      style: TextStyle(color: Colors.white),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(
        from.year, from.month, from.day, from.hour, from.minute, from.second);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
    return (to.difference(from).inSeconds - 7 * 60 * 60);
  }
}
