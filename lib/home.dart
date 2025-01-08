import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:sms/amazon.dart';
import 'news.dart';
import 'service_screen.dart'; // Import the ServiceScreen

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<Map<String, String>> addedServices = []; // Store added services

  // Function to add selected service to the list
  void _addService(String serviceName, String serviceIcon, String plan) {
    DateTime startDate = DateTime.now();
    DateTime endDate;

    switch (plan) {
      case '1 Month':
        endDate = startDate.add(const Duration(days: 30));
        break;
      case '6 Months':
        endDate = startDate.add(const Duration(days: 180));
        break;
      case '1 Year':
        endDate = startDate.add(const Duration(days: 365));
        break;
      default:
        endDate = startDate;
    }

    String formattedStartDate = DateFormat('MMM dd, yyyy').format(startDate);
    String formattedEndDate = DateFormat('MMM dd, yyyy').format(endDate);

    setState(() {
      addedServices.add({
        'name': serviceName,
        'icon': serviceIcon,
        'plan': plan,
        'duration': '$formattedStartDate - $formattedEndDate',
        'endDate': endDate.toIso8601String(), // Store end date as ISO string
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leading: const Icon(Icons.settings, color: Colors.black),
        actions: const [Icon(Icons.notifications, color: Colors.black)],
        title: const Text(
          'Subscription Management',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue.shade200,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Your Services:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // Horizontal Scrollable Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Add Service Card with "+" icon
                    ServiceCard(
                      title: 'Add Service',
                      iconPath: "images/plus_icon.png", // Plus icon
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceScreen(
                            onServiceSelected: _addService,
                          ),
                        ),
                      ),
                      isAddServiceCard: true, // Flag for add service card
                      plan: '',
                      duration: '',
                    ),
                    // Dynamically show added services next to Add Service
                    for (var service in addedServices)
                      ServiceCard(
                        title: service['name']!,
                        iconPath: service['icon']!,
                        onTap: () {},
                        isAddServiceCard: false,
                        plan: service['plan']!,
                        duration: service['duration']!,
                        endDate: service['endDate'], // Pass end date here
                      ),

                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Popular Services Section (showing only 4 services)
              const Text(
                'Popular Services:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              PopularServices(),

              SizedBox(height: 20,),
              const SizedBox(height: 16),

              const Text(
                'Top News',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // News Cards Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NewsCard(
                    icon: Icons.article_outlined,
                    title:
                    'Buying a PS5 Pro Is Apparently a Console Lottery, Depending on the Pa...',
                    source: 'VICE',
                    date: 'Nov 17, 2024',
                  ),
                  const SizedBox(height: 8),
                  NewsCard(
                    icon: Icons.search_outlined,
                    title:
                    'I just tested Google vs ChatGPT search — and I’m shocked by the results',
                    source: 'TOM\'S GUIDE',
                    date: 'Nov 4, 2024',
                  ),
                  const SizedBox(height: 8),
                  NewsCard(
                    icon: Icons.local_gas_station_outlined,
                    title:
                    'Amazon\'s Latest Prime Perk Will Help You Save Money on Gas',
                    source: 'PC MAG',
                    date: 'Oct 24, 2024',
                  ),
                  const SizedBox(height: 8),
                  NewsCard(
                    icon: Icons.videogame_asset_outlined,
                    title:
                    'Microsoft’s new Xbox Series X models have a smaller chip and different cooli...',
                    source: 'THE VERGE',
                    date: 'Oct 15, 2024',
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // "More News" Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () { Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  NewsScreen()),
                  );},
                  child: const Text('MORE NEWS'),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'PRICE INCREASES',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Horizontal Scroll for Price Increases
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    PriceCard(
                      icon: Icons.subscriptions_outlined,
                      label: 'Microsoft 365 FAMILY',
                      percentage: '+29%',
                    ),
                    PriceCard(
                      icon: Icons.subscriptions_outlined,
                      label: 'Microsoft 365 PERSONAL',
                      percentage: '+45%',
                    ),
                    PriceCard(
                      icon: Icons.subscriptions_outlined,
                      label: 'Google Cloud',
                      percentage: '+15%',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceScreen(
              onServiceSelected: _addService,
            ),
          ),
        ),
        backgroundColor: Colors.blue.shade600,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool isAddServiceCard;
  final String plan;
  final String duration;
  final String? endDate; // Add endDate field

  const ServiceCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    required this.isAddServiceCard,
    required this.plan,
    required this.duration,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    int daysLeft = 0;
    if (endDate != null) {
      DateTime now = DateTime.now();
      DateTime end = DateTime.parse(endDate!);
      daysLeft = end.difference(now).inDays;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 140,
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isAddServiceCard)
              const Icon(
                Icons.add,
                size: 40,
                color: Colors.blue,
              )
            else
              Image.asset(
                iconPath,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 40,
                    color: Colors.grey,
                  );
                },
              ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            if (!isAddServiceCard && plan.isNotEmpty)
              Text(
                plan,
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            if (!isAddServiceCard && duration.isNotEmpty)
              Text(
                duration,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: Colors.black45),
              ),
            if (!isAddServiceCard && daysLeft > 0)
              Text(
                '$daysLeft days left',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PopularServices extends StatelessWidget {
  final List<Map<String, String>> services = [
    {"name": "Amazon Prime", "icon": "images/a2.png"},
    {"name": "Spotify", "icon": "images/s.png"},
    {"name": "YouTube", "icon": "images/y.png"},
    {"name": "Google One", "icon": "images/one.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: services.map((service) {
          return InkWell(
            onTap: () {
              print("Navigating to Amazon Screen");
              // Navigate to amazon screen when tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => amazon()),
              );
            },
            child: ServiceCard(
              title: service['name']!,
              iconPath: service['icon']!,
              onTap: () {},
              isAddServiceCard: false,
              plan: '',
              duration: '',
            ),
          );
        }).toList(),
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String percentage;

  const PriceCard({
    super.key,
    required this.icon,
    required this.label,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 140,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue.shade500, size: 40),
          const SizedBox(height: 8),
          Text(
            percentage,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String source;
  final String date;

  const NewsCard({
    required this.icon,
    required this.title,
    required this.source,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue.shade600, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$source • $date',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
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