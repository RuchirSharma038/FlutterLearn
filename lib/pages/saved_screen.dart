import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/home_page.dart';
import 'package:flutter_application_4/pages/news_details.dart';
import 'package:flutter_application_4/pages/search_screen.dart';
import 'package:hive/hive.dart';

class MySaved extends StatefulWidget {
  // final Map<String,dynamic>article;
  const MySaved({super.key});
  @override
  State<MySaved> createState() => _SavedPageState();
}

class _SavedPageState extends State<MySaved> {
  int selectedIndex = 2;
  late Box savedArticlesBox;
  //final List<Map<String,dynamic>> articles1 = Hive.box('saved_articles').values.toList();
  //List<Map<String, dynamic>> articles = (List<Map<String,dynamic>>)articles1;
  List<Map<String, dynamic>> articles = [];

  @override
  void initState() {
    super.initState();
    savedArticlesBox = Hive.box('saved_articles');
    loadSavedArticles();
  }

  void loadSavedArticles() {
    setState(() {
      articles = savedArticlesBox.values
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    });
  }

  Widget listofArticles(final int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyDetails(index: index, articles: articles),
          ),
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
                articles[index]['urlToImage'],

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
                    'Source: ${articles[index]['source']['name']}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // 'By: ${articles[index]['author']}',
                    articles[index]['author'] == null
                        ? 'By: Unknown'
                        : 'By: ${articles[index]['author']}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Published: ${articles[index]['publishedAt'].toString().split('T')[0]}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          ),
        ],
        title: Text(
          'NewsApp',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            // SizedBox(height: 40);
            return listofArticles(index);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
          switch (selectedIndex) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MySearch()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MySaved()),
              );
              break;
          }
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
