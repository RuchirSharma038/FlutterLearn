import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/home_page.dart';
import 'package:flutter_application_4/pages/ent_page.dart';
import 'package:flutter_application_4/pages/news_details.dart';
import 'package:flutter_application_4/pages/profile_page.dart';
import 'package:flutter_application_4/pages/saved_screen.dart';
import 'package:flutter_application_4/pages/search_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:flutter_application_4/pages/sports_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:flutter_application_4/pages/news_details.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  List<Map<String, dynamic>> articles = [];

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    String? apiKey = dotenv.env['API_KEY'];
    final url =
        'https://newsapi.org/v2/top-headlines?category=sports&apiKey=$apiKey';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          articles = List<Map<String, dynamic>>.from(data['articles']);
        });
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      AlertDialog(actions: [Text('Failed to fetch articles ')]);
    }
  }

  int selectedIndex = 0;

  Widget buildButton(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButton = index;
        });

        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EntPage()),
          );
        }
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
                    articles[index]['author'] == null
                        ? 'By: Unknown'
                        : 'By: ${articles[index]['author']}',
                    // 'By:  ${articles[index]['author'] == null? Unknown:articles[index]['author'] }',
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

  int selectedButton = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.white,
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
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfile()),
                );
              },
              icon: Icon(Icons.person),
            ),
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
                buildButton(0, "Tech"),
                buildButton(1, "Sports"),
                buildButton(2, "Enterainment"),
              ],
            ),
            SizedBox(height: 50),

            // listofArticles(0),
            // SizedBox(height: 20),
            // listofArticles(1),
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
                MaterialPageRoute(builder: (context) => SportsPage()),
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

// Widget _buildButton(int index, String title){
//   return GestureDetector(
//     onTap: (){setState((){selected})},
//   )
// }
