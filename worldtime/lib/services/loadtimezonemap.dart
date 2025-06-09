import 'dart:convert';
import 'package:http/http.dart' as http;

class ZoneService {
  // our in-memory cache
  static Map<String, List<String>>? _cachedZones;

  /// Returns the region→zones map, fetching only on the first call.
  static Future<Map<String, List<String>>> getZonesByRegion() async {
    if (_cachedZones != null) return _cachedZones!;

    final uri = Uri.parse(
      'https://timeapi.io/api/TimeZone/AvailableTimeZones',
    );
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Failed to load time zones: ${resp.statusCode}');
    }

    final List<String> zones = List<String>.from(jsonDecode(resp.body));
    final map = <String, List<String>>{};
    for (var zone in zones) {
      final parts = zone.split('/');
      if (parts.length < 2) continue;
      final region = parts.first;
      final city = parts.sublist(1).join('/');
      map.putIfAbsent(region, () => []).add(city);
    }

    _cachedZones = map;           // cache it
    return _cachedZones!;
  }
}
