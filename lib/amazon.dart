import 'package:flutter/material.dart';
class amazon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return amazon1(); // Return amazon1 widget
  }
}

class amazon1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services',textDirection: TextDirection.ltr,),
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildPlanTile('Request more plans', 'Submit new plans for review'),
                  _buildPlanTile('MONTHLY', '₹299/mo'),
                  _buildPlanTile('SHOPPING', '₹399/an'),
                  _buildPlanTile('QUARTERLY', '₹599/3mo'),
                  _buildPlanTile('ANNUAL LITE', '₹799/an'),
                  _buildPlanTile('ANNUAL', '₹1,499/an'),
                  _buildPlanTile('Other Plan', 'Add a custom subscription to your list'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Plans verified on November 2024',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanTile(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey),
      ),
      trailing: Icon(Icons.arrow_forward, color: Colors.grey),
      tileColor: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: () {
        // Add onTap functionality here
      },
    );
  }
}
