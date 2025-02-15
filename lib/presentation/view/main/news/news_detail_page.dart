import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';

// ignore: must_be_immutable
class NewsDetailPage extends StatefulWidget {
  int? index;
  NewsDetailPage({super.key, this.index});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('News Detail'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.bookmark,
                color: Colors.grey,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: 'news-title+${widget.index}',
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "New type durian is confirmed to double the productivity ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              Hero(
                  tag: 'news-image+${widget.index}',
                  child: SizedBox(
                      height: 300,
                      child: Image.network(
                        FakeData.fakeFields.first.imageUrl!,
                        fit: BoxFit.cover,
                      ))),
              const SizedBox(height: 10),
              Hero(
                tag: 'news-author+${widget.index}',
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          "https://ca.billboard.com/media-library/kendrick-lamar-squabble-up.jpg?id=54979656&width=1200&height=800&quality=90&coordinates=6%2C0%2C6%2C0",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Kendrick Lamar',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const Text(
                      ' · ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Follow",
                          style: AppTextStyle.defaultBold(
                              color: AppColors.accentColor),
                        )),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Agriculture",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, ultricies nunc. Nulla facilisi. Nullam ac nisi non nunc tincidunt aliquam).",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 2,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              width: MediaQuery.of(context).size.width -
                                  30 -
                                  2, // Subtracting the width of the first container
                              height:
                                  50, // Setting the same height as the first container
                              decoration: BoxDecoration(
                                color: AppColors.accentColor.withOpacity(0.1),
                              ),
                              child: const Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat",
                                style: TextStyle(
                                    color: AppColors.accentColor,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, ultricies nunc. Nulla facilisi. Nullam ac nisi non nunc tincidunt aliquam.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, ultricies nunc. Nulla facilisi. Nullam ac nisi non nunc tincidunt aliquam.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, ultricies nunc. Nulla facilisi. Nullam ac nisi non nunc tincidunt aliquam.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, ultricies nunc. Nulla facilisi. Nullam ac nisi non nunc tincidunt aliquam.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, ultricies nunc. Nulla facilisi. Nullam ac nisi non nunc tincidunt aliquam).",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  )),
            ],
          ),
        ));
  }
}
