import 'package:flutter/material.dart';

class MyDetails extends StatelessWidget {
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
  final int index;
  MyDetails({super.key, required this.index});

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
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
      body: Container(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 40),
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),

                child: Image.network(
                  articles[index]['urlToImage'],

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      'https://dummyimage.com/300x150/cccccc/ffffff&text=.',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                  height: 300,
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
                      articles[index]['title'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ' ${articles[index]['source']['name']}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'By: ${articles[index]['author']}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Published: ${articles[index]['publishedAt'].toString().split('T')[0]}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      ' ${articles[index]['description']}',
                      style: TextStyle(color: Colors.black87, fontSize: 15),
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
      ),
    );
  }
}
