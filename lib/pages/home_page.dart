import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/news_details.dart';
//import 'package:flutter_application_4/pages/news_details.dart';

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> articles = [
    {
      "source": {"id": null, "name": "CounterPunch"},
      "author": "Jeffrey St. Clair",
      "title": "Hell and High Water: the Year in Climate Chaos",
      "description": "2024 will be the warmest year on record...",
      "url":
          "https://www.counterpunch.org/2024/12/20/hell-and-high-water-the-year-in-climate-chaos/",
      "urlToImage":
          "https://www.counterpunch.org/wp-content/uploads/2024/12/flaglongview-scaled.jpeg",
      "publishedAt": "2024-12-20T06:59:11Z",
      "content": "Industrial plants, Port of Longview...",
    },
    {
      "source": {"id": null, "name": "Neuwritesd.org"},
      "author": "Vani Taluja",
      "title": "A 3D Camera for the Brain: The Simplified Science of MRI",
      "description":
          "Have you ever dreamed of having Superman’s power of “X-Ray Vision...",
      "url":
          "https://neuwritesd.org/2024/12/19/a-3d-camera-for-the-brain-the-simplified-science-of-mri/",
      "urlToImage":
          "https://neuwritesd.org/wp-content/uploads/2024/12/mris.jpeg?w=1200",
      "publishedAt": "2024-12-20T04:52:29Z",
      "content": "Posted by Vani Taluja on December 19, 2024 in NeuWrite...",
    },
  ];

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  Widget _buildButton(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButton = index;
        });
      },

      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: selectedButton == index ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 2),
        ),

        child: Text(
          title,
          style: TextStyle(
            color: selectedButton == index ? Colors.white : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget listofArticles(final int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyDetails(index: index)),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 40),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),

              child: Image.network(
                widget.articles[index]['urlToImage'],

                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://dummyimage.com/200x150/cccccc/ffffff&text=.',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.articles[index]['title'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Source: ${widget.articles[index]['source']['name']}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By: ${widget.articles[index]['author']}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Published: ${widget.articles[index]['publishedAt'].toString().split('T')[0]}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                ],
              ),
            ),

            // Text(widget.articles[index]['title'], maxLines: 2),
            // SizedBox(height: 10),
            // Row(
            //   children: [
            //     Text(widget.articles[index]['author']),
            //     SizedBox(width: 100),
            //     Text(
            //       widget.articles[index]['publishedAt'].toString().split(
            //         'T',
            //       )[0],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  int selectedButton = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsetsGeometry.only(left: 16.0),
          child: Text(
            'NewsApp',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton(0, "Tech"),
                _buildButton(1, "Sports"),
                _buildButton(2, "Cinema"),
              ],
            ),
            SizedBox(height: 50),

            // listofArticles(0),
            // SizedBox(height: 20),
            // listofArticles(1),
            Expanded(
              child: ListView.builder(
                itemCount: widget.articles.length,
                itemBuilder: (context, index) {
                  // SizedBox(height: 40);
                  return listofArticles(index);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Saved'),
        ],
      ),
    );
  }
}

// Widget _buildButton(int index, String title){
//   return GestureDetector(
//     onTap: (){setState((){selected})},
//   )
// }
