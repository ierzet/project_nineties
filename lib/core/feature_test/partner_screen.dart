import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PartnerScreen extends StatefulWidget {
  const PartnerScreen({super.key});

  @override
  State<PartnerScreen> createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  late Future<List<PartnerEntity>> futurePartners;

  @override
  void initState() {
    super.initState();
    //ambil token menggunakan postman
    //endpoint post http://localhost:3000/api/auth/login
    //masukan parameter json di bawah ini dan send
    //     {
    //   "email": "user1@example.com",
    //   "password": "password123"
    // }
    //copy token dan input ke dalam savatoken di bawah ini
    saveToken(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2Nzk2NjBlNWE5YzExOWE0YWQxYjgzM2UiLCJlbWFpbCI6InVzZXJAZXhhbXBsZS5jb20iLCJyb2xlIjoidXNlciIsImlhdCI6MTczODA1MzU1OSwiZXhwIjoxNzM4MDU3MTU5fQ.k46kT00WtI_wYdwPVZAdpQvHENFxqiIGARUtIiT4EsI');
    futurePartners = fetchPartners();
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<List<PartnerEntity>> fetchPartners() async {
    const String baseUrl =
        'http://192.168.1.11:3000'; // Replace with your local IP
    final String url = '$baseUrl/api/partners/';

    try {
      // Retrieve the token from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('jwt_token');

      // Set up the headers
      final headers = {
        'Authorization':
            'Bearer $token', // Include the token in the Authorization header
        //'Content-Type': 'application/json', // Optional: specify content type
      };

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> partnersData =
            jsonResponse['data']; // Access the 'data' field

        return partnersData
            .map((partner) => PartnerModel.fromAPI(partner).toEntity())
            .toList();
      } else {
        throw Exception('Failed to load partners: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Failed to load partners: $e');
    }
  }

  // Future<List<PartnerEntity>> fetchPartners() async {
  //   //print('halo...');
  //   try {
  //     final response =
  //         await http.get(Uri.parse('http://localhost:3000/api/partners/'));

  //     if (response.statusCode == 200) {
  //       List jsonResponse = json.decode(response.body);
  //       // print('jsonResponse: $jsonResponse');
  //       return jsonResponse
  //           .map((partner) => PartnerModel.fromJson(partner).toEntity())
  //           .toList();
  //     } else {
  //       throw Exception('Failed to load partners');
  //     }
  //   } on Exception catch (e) {
  //     throw Exception('Failed to load partners: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Future<void> insertData() async {
      const String baseUrl =
          'http://192.168.1.11:3000'; // Replace localhost with your local IP
      final String url = '$baseUrl/api/partners/';
      // Hardcoded JSON data for the new partner
      final Map<String, dynamic> partnerData = {
        "partner_address":
            "jl. Achmad Adna Wijaya no.18 kec, Bogor Utara kota bogor",
        "partner_created_by": "sUbhG0v5R6hNgOoV8QO1dQQifZu1",
        "partner_created_date": "2024-12-31T16:18:28+07:00",
        "partner_deleted_by": "",
        "partner_deleted_date": null,
        "partner_email": "90sautowroosn@gmail.com",
        "partner_id": "90sautowroosn@gmail.com",
        "partner_image_url":
            "https://firebasestorage.googleapis.com/v0/b/project-id.appspot.com/o/image.jpg?alt=media&token=token",
        "partner_is_deleted": false,
        "partner_name": "Sample Partner", // Add any additional required fields
        "partner_phone_number":
            "1234567890", // Add any additional required fields
        "partner_status": "active", // Add any additional required fields
        "partner_join_date": DateTime.now().toIso8601String(), // Current date
      };

      try {
        final prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('jwt_token');
        // Send a POST request to the API
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(partnerData),
        );

        // Check the response status
        if (response.statusCode == 201) {
          // Successfully created
          print('Partner created: ${response.body}');
        } else {
          // Handle error
          print(
              'Failed to create partner: ${response.statusCode} - ${response.body}');
        }
      } catch (e) {
        // Handle any exceptions
        print('Error: $e');
      }
    }

    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: Center(
        child: FutureBuilder<List<PartnerEntity>>(
          future: futurePartners,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return Text("${snapshot.error}");
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  //print('snapshot.data: ${snapshot.data}');
                  final partner = snapshot.data![index];
                  return ListTile(
                    title: Text('name :${partner.partnerName!}'),
                    subtitle: Text('email :${partner.partnerEmail!}'),
                    trailing: IconButton(
                        onPressed: insertData, icon: const Icon(Icons.add)),
                  );
                },
              );
              //return Text(snapshot.data!.length.toString());
            }
          },
        ),
      ),
    );
  }
}
