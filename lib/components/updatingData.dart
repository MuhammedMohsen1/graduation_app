import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' show atan2, cos, pi, sin, sqrt;

Future<void> addTestToFirestore(
  String name,
  String owner,
  int time,
  double gpsLat,
  double gpsLong,
  double temperature,
  double turbidity,
  double tds,
  double ph,
  double conductivity,
  double oxygen,
  double Polluted,
) async {
  try {
    // Get a reference to the Firestore collection
    CollectionReference testsCollection =
        FirebaseFirestore.instance.collection('tests');

    // Create a new document in the tests collection
    DocumentReference newTestRef = testsCollection.doc();

    // Set the data for the new document
    await newTestRef.set({
      'owner': owner,
      'name': name,
      'time': time,
      'gpsLat': gpsLat,
      'gpsLong': gpsLong,
      'temperature': temperature,
      'turbidity': turbidity,
      'tds': tds,
      'ph': ph,
      'conductivity': conductivity,
      'oxygen': oxygen,
      'polluted': Polluted, // 0 for polluted  1 for clean
    });

    print('Test added to Firestore with ID: ${newTestRef.id}');
  } catch (e) {
    print('Error adding test to Firestore: $e');
  }
}

Future<void> addTestOrdersToFirestore(
  String email,
  int time,
  double gpsLat,
  double gpsLong,
) async {
  try {
    // Get a reference to the Firestore collection
    CollectionReference testsCollection =
        FirebaseFirestore.instance.collection('test_orders');

    // Create a new document in the tests collection
    DocumentReference newTestRef = testsCollection.doc();

    // Set the data for the new document
    await newTestRef.set({
      'email': email,
      'time': time,
      'gpsLat': gpsLat,
      'gpsLong': gpsLong,
      'status': 'waiting...',
      'result': 'waiting...',
    });

    print('Test Order added to Firestore with ID: ${newTestRef.id}');
  } catch (e) {
    print('Error adding test Order to Firestore: $e');
  }
}

Future<void> UpdateTestOrdersToFirestore(
    String collection, String docId, String result) async {
  try {
    // Get a reference to the Firestore collection
    CollectionReference testsCollection =
        FirebaseFirestore.instance.collection(collection);

    // Create a new document in the tests collection
    DocumentReference newTestRef = testsCollection.doc(docId);

    // Set the data for the new document
    await newTestRef.update({
      'status': 'done',
      'result': result,
    });

    print('Test Order Deleted to Firestore with ID: ${newTestRef.id}');
  } catch (e) {
    print('Error Deleting test Order from  Firestore: $e');
  }
}

Future<List<Map<String, dynamic>>> fetchTestOrdersFromFirestore() async {
  List<Map<String, dynamic>> testList = [];

  try {
    // Get a reference to the Firestore collection
    CollectionReference testsCollection =
        FirebaseFirestore.instance.collection('test_orders');

    // Query the collection for all documents
    QuerySnapshot querySnapshot = await testsCollection.get();

    // Loop through the documents and add the data for each one to the testList
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> testMap = {
        'id': doc.id,
        'time': doc.get('time'),
        'email': doc.get('email'),
        'gpsLat': doc.get('gpsLat'),
        'gpsLong': doc.get('gpsLong'),
        'status': doc.get('status'),
        'result': doc.get('result'),
      };
      testList.add(testMap);
    }
  } catch (e) {
    print('Error fetching tests from Firestore: $e');
  }

  return testList;
}

Future<List<Map<String, dynamic>>> fetchTestsFromFirestore() async {
  List<Map<String, dynamic>> testList = [];

  try {
    // Get a reference to the Firestore collection
    CollectionReference testsCollection =
        FirebaseFirestore.instance.collection('tests');

    // Query the collection for all documents
    QuerySnapshot querySnapshot = await testsCollection.get();

    // Loop through the documents and add the data for each one to the testList
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> testMap = {
        'id': doc.id,
        'time': doc.get('time'),
        'name': doc.get('name'),
        'polluted': doc.get('polluted'),
        'gpsLat': doc.get('gpsLat'),
        'gpsLong': doc.get('gpsLong'),
        'temperature': doc.get('temperature'),
        'turbidity': doc.get('turbidity'),
        'tds': doc.get('tds'),
        'ph': doc.get('ph'),
        'conductivity': doc.get('conductivity'),
        'oxygen': doc.get('oxygen'),
      };
      testList.add(testMap);
    }
  } catch (e) {
    print('Error fetching tests from Firestore: $e');
  }

  return testList;
}

Map<String, dynamic> findNearestLocation(
    double myLat, double myLon, List<Map<String, dynamic>> locations) {
  double minDistance = double.infinity;
  Map<String, dynamic> nearestLocation = {};

  for (Map<String, dynamic> location in locations) {
    final lat = location['gpsLat'] as double;
    final lon = location['gpsLong'] as double;

    final distance = _haversine(myLat, myLon, lat, lon);

    if (distance < minDistance) {
      minDistance = distance;
      nearestLocation = location;
    }
  }

  return nearestLocation;
}

double _haversine(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371.0; // Earth's radius in kilometers

  final dLat = _toRadians(lat2 - lat1);
  final dLon = _toRadians(lon2 - lon1);

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_toRadians(lat1)) *
          cos(_toRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c;
}

double _toRadians(double degrees) {
  return degrees * pi / 180;
}
