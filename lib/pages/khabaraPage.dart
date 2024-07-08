import 'package:danshjoyar/NewsHandling/api_service.dart';
import 'package:danshjoyar/NewsHandling/article_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class khabara extends StatefulWidget {
  const khabara({super.key});

  @override
  State<khabara> createState() => _khabaraState();
}

class _khabaraState extends State<khabara> {
  late Future<ApiResponse> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = ApiService.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: IntrinsicHeight(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "lib/asset/images/casey-horner-4rDCa5hBlCs-unsplash.jpg",
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
              ),
            ),
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.height / 25,
              MediaQuery.of(context).size.height / 10,
              MediaQuery.of(context).size.height / 25,
              MediaQuery.of(context).size.height / 25,
            ),
            child: FutureBuilder<ApiResponse>(
              future: futureArticles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color:Colors.white,strokeAlign: 50,));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(

                    itemCount: snapshot.data!.articles.length,
                    itemBuilder: (context, index) {
                      final article = snapshot.data!.articles[index];
                      return Card(
                        shadowColor:  Colors.cyan.shade200,

                        color: Colors.white60,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10.0),
                          title: Text(
                            article.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              article.author ?? 'Unknown Author',
                              style: TextStyle(
                                color: Colors.black54
                              ),
                            ),
                          ),
                          leading: article.urlToImage != null
                              ? ClipRRect(

                                  borderRadius: BorderRadius.circular(8.0),

                                  child: Image.network(
                                    article.urlToImage!,
                                    width: 120.0,
                                    height: 120.0,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : null,
                          onTap: () {
                            _launchURL(Uri.parse(article.url));
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No articles found'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------

  _launchURL(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
}
