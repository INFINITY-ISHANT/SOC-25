import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:worldtime/services/gettime.dart';
import 'package:worldtime/services/loadtimezonemap.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Map<String, List<String>> _zonesByRegion = {};
  String? _selectedRegion;
  String? _selectedZone;

  @override
  void initState() {
    super.initState();
    // load once—will use cache on subsequent calls
    ZoneService.getZonesByRegion().then((map) {
      setState(() {
        _zonesByRegion = map;
      });
    }).catchError((e) {
      // handle error (e.g. show snackbar)
      print('Error loading zones: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    final regionItems = _zonesByRegion.keys
        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
        .toList();

    final List<DropdownMenuItem<String>> cityItems =
    (_selectedRegion == null)
        ? <DropdownMenuItem<String>>[]
        : _zonesByRegion[_selectedRegion]!
        .map<DropdownMenuItem<String>>((city) {
      return DropdownMenuItem<String>(
        value: city,
        child: Text(city),
      );
    })
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Choose your location')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _zonesByRegion.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Region dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Region'),
              items: regionItems,
              value: _selectedRegion,
              onChanged: (r) {
                setState(() {
                  _selectedRegion = r;
                  _selectedZone = null;
                });
              },
            ),
            const SizedBox(height: 16),
            // City / subregion dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'City / Zone'),
              items: cityItems,
              value: _selectedZone,
              onChanged: (z) {
                setState(() {
                  _selectedZone = z;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: (_selectedRegion == null || _selectedZone == null)
                  ? null
                  : () async {
                final fullZone =
                    '$_selectedRegion/$_selectedZone';
                // fetch the time for that zone
                WorldTime wt = WorldTime(
                  location: _selectedZone!.replaceAll('_', ' '),
                  flag: 'globe.png', // or map region→flag
                  url: fullZone,
                );
                await wt.getTime();
                Navigator.pop(context, {
                  'location': wt.location,
                  'flag': wt.flag,
                  'time': wt.time,
                  'isdaytime': wt.isdaytime,
                });
              },
              child: const Text('Get Local Time'),
            ),
          ],
        ),
      ),
    );
  }
}
