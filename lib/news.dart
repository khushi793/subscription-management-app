import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  // Function to open the URL
  void _openURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Immediately open the URL when the screen is displayed
    Future.delayed(Duration.zero, () {
      _openURL("https://www.cnbctv18.com/technology/elon-musk-x-premium-subscription-plan-price-hike-india-19528529.htm"); // Replace with your URL
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription News"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: CircularProgressIndicator(), // Show loading indicator while redirecting
      ),
    );
  }
}
