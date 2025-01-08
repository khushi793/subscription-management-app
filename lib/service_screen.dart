import 'package:flutter/material.dart';

class ServiceScreen extends StatelessWidget {
  final Function(String, String, String) onServiceSelected;

  ServiceScreen({Key? key, required this.onServiceSelected}) : super(key: key);

  final List<Map<String, String>> services = [
    {"name": "Amazon Prime", "icon": "images/a2.png"},
    {"name": "Spotify", "icon": "images/s.png"},
    {"name": "YouTube", "icon": "images/y.png"},
    {"name": "Google One", "icon": "images/one.png"},
    {"name": "Xbox", "icon": "images/xbox.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Service'),
        backgroundColor: Colors.blue.shade200,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.2,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return _buildServiceCard(
              context,
              services[index]['name']!,
              services[index]['icon']!,
            );
          },
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, String serviceName, String iconPath) {
    return InkWell(
      onTap: () {
        _showSubscriptionPopup(context, serviceName, iconPath);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 60, height: 60),
            const SizedBox(height: 8),
            Text(
              serviceName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSubscriptionPopup(
      BuildContext context, String serviceName, String serviceIcon) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.asset(serviceIcon, width: 50, height: 50),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$serviceName Subscription Plans',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSubscriptionOption(
                    context, '1 Month', serviceName, serviceIcon),
                _buildSubscriptionOption(
                    context, '6 Months', serviceName, serviceIcon),
                _buildSubscriptionOption(
                    context, '1 Year', serviceName, serviceIcon),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubscriptionOption(BuildContext context, String plan,
      String serviceName, String serviceIcon) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
        onServiceSelected(serviceName, serviceIcon, plan);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              plan,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
