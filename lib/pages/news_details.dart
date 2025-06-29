import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyDetails extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> articles;

  const MyDetails({super.key, required this.index, required this.articles});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> article = articles[index];
    final Box savedArticlesBox = Hive.box('saved_articles');
    final String uniqueKey = article['url'];
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
      body: Card(
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
                articles[index]['urlToImage'] ??
                    'https://dummyimage.com/200x150/cccccc/ffffff&text=No+Image',

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
                    articles[index]['title'] ?? 'No title',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ' ${articles[index]['source']?['name'] ?? 'Unknown'}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By: ${articles[index]['author'] ?? 'Unknown'}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Published: ${articles[index]['publishedAt']?.toString().split('T')[0] ?? 'Date not found'}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (!savedArticlesBox.containsKey(uniqueKey)) {
                            savedArticlesBox.put(uniqueKey, article);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Article saved!')),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 35,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Mark as fav.',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      SizedBox(width: 70),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          if (savedArticlesBox.containsKey(uniqueKey)) {
                            savedArticlesBox.delete(uniqueKey);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Article removed from saved'),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    ' ${articles[index]['description'] ?? 'No details '}',
                    style: TextStyle(color: Colors.black87, fontSize: 15),
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
