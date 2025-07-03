import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/home_page.dart';
import 'package:flutter_application_4/pages/news_details.dart';
import 'package:flutter_application_4/pages/saved_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _SearchPageState();
}

class _SearchPageState extends State<MySearch> {
  String query = '';
  List<Map<String, dynamic>> articles = [];
  int selectedIndex = 1;

  Future<void> fetchArticles() async {
    if (!mounted) return;
    String? apiKey = dotenv.env['API_KEY'];
    if (query.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Query cannot be empty")));
      return;
    }
    //if (context.mounted) {
    try {
      final response = await http.get(
        Uri.parse('https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (mounted) {
          setState(() {
            articles = List<Map<String, dynamic>>.from(data['articles']);
          });
        }
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to fetch articles')));
    }
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
                articles[index]['urlToImage'] ??
                    'https://dummyimage.com/200x150/cccccc/ffffff&text=No+Image',

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
                    articles[index]['title'] ?? 'No Title Available',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Source: ${articles[index]['source']?['name'] ?? 'Unknown Source'}',
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
                    'Published: ${articles[index]['publishedAt']?.toString().split('T')[0] ?? 'Unknown Date'}',
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

        title: Text(
          'NewsApp',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.black, width: 1),
              ),

              child: TextField(
                controller: TextEditingController(text: query),
                decoration: InputDecoration(
                  hintText: 'Search here',
                  contentPadding: EdgeInsets.all(10),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      fetchArticles();
                    },
                  ),

                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  query = value;
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                // SizedBox(height: 40);
                return listofArticles(index);
              },
            ),
          ),
        ],
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
