import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/partner/data/models/partner_model.dart';
import 'package:project_nineties/features/partner/domain/entities/partner_entity.dart';

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
    futurePartners = fetchPartners();
  }

  Future<List<PartnerEntity>> fetchPartners() async {
    //print('halo...');
    final response =
        await http.get(Uri.parse('http://192.168.1.24:3000/api/partners/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      // print('jsonResponse: $jsonResponse');
      return jsonResponse
          .map((partner) => PartnerModel.fromJson(partner).toEntity())
          .toList();
    } else {
      throw Exception('Failed to load partners');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarNoAvatar(),
      body: Center(
        child: FutureBuilder<List<PartnerEntity>>(
          future: futurePartners,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print(snapshot.error);
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
