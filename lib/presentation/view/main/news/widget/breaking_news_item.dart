import 'package:flutter/material.dart';
import 'package:green_fairm/presentation/view/main/news/news_detail_page.dart';

// ignore: must_be_immutable
class BreakingNewsItem extends StatelessWidget {
  int? index;
  BreakingNewsItem({super.key, this.index});

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
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Stack(
          children: [
            Hero(
              tag: 'news-image+$index',
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://eo.dhigroup.com/wp-content/uploads/sites/9/2018/12/shutterstock_284139386.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'news-title+$index',
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: const Text(
                        'New type durian is confirmed to double the productivity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
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
                        'Kendrick Lamar · 3 hours ago',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
