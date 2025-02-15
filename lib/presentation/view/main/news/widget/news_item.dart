import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/presentation/view/main/news/news_detail_page.dart';

// ignore: must_be_immutable
class NewsItem extends StatelessWidget {
  int? index;
  NewsItem({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(
              index: index,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Hero(
              tag: 'news-image+$index',
              child: SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    FakeData.fakeFields.first.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
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
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const Text(
                      '· 3 hour ago',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
                Hero(
                  tag: 'news-title+$index',
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: const Text(
                        "New type durian is confirmed to double the productivity ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.primaryColor.withOpacity(0.1),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: const Text("Market",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            )),
                      ),
                      const Spacer(),
                      const Icon(Icons.bookmark_border),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
