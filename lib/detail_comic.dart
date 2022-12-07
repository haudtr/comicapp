import 'package:flutter/material.dart';

class DetailComic extends StatefulWidget {
  const DetailComic({super.key});

  @override
  State<DetailComic> createState() => _DetailComicState();
}

class _DetailComicState extends State<DetailComic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.view_list,
                        size: 30,
                      ))
                ],
              ),
            ),
            Image.asset("assets/images/Rectangle 30.png"),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    child: Text(
                      "Komi san Cant Communicate",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 146, 198, 224),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(Icons.heart_broken),
                          Text("61"),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
