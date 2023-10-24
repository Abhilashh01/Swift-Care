import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 0, 255, 208),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ambulance Guide',
      theme: theme,
      home: LocationSelectionPage(),
    );
  }
}

class LocationSelectionPage extends StatelessWidget {
  final List<Location> locations = [
    Location('Banashankari', [
      'Apollo Hospital',
      'Sagar Hospitals',
      'BMS Hospitals',
    ]),
    Location('Yeshwantpur', [
      'People Tree Hospital',
      'Sparsh Multi-Specialty Hospital',
      'Manipal Hospitals',
      'Acharya Tulsi jain Hospitals',
    ]),
    Location('Nagasandra', [
      'Prakriya Hospitals',
      'Saptagiri Hospitals',
      'Sarojini Health Center',
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Area'),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the border radius as needed
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24), // Adjust the padding as needed
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HospitalListPage(location),
                  ),
                );
              },
              child: Text(location.name),
            ),
          );
        },
      ),
    );
  }
}

class Location {
  final String name;
  final List<String> hospitals;

  Location(this.name, this.hospitals);
}

class HospitalListPage extends StatelessWidget {
  final Location location;

  HospitalListPage(this.location);

  Future<void> _launchMaps(String destination) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$destination';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospitals in ${location.name}'),
      ),
      body: ListView.builder(
        itemCount: location.hospitals.length,
        itemBuilder: (context, index) {
          final hospital = location.hospitals[index];
          return Card(
            child: ListTile(
              title: Text(hospital),
              onTap: () {
                _launchMaps(hospital);
              },
              trailing: const Icon(Icons.location_on),
            ),
          );
        },
      ),
    );
  }
}
