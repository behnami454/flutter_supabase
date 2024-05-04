import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase/blocs/places_bloc/places_bloc.dart';
import 'package:flutter_supabase/configs/routes.dart';
import 'package:flutter_supabase/configs/shared_prefrences.dart';
import 'package:flutter_supabase/screens/review_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PreferencesService _preferencesService = PreferencesService();

  @override
  void initState() {
    super.initState();
    context.read<PlaceBloc>().add(LoadPlaces());
  }

  Future<void> _logout() async {
    var logoutNavigation = Navigator.pushReplacementNamed(context, Routes.routeLogin);
    await _preferencesService.setLoggedIn(false);
    logoutNavigation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
        backgroundColor: Colors.blueGrey,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PlaceLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PlaceBloc>().add(LoadPlaces());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.places.length,
                  itemBuilder: (context, index) {
                    final place = state.places[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(place.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(place.description),
                          trailing: Text(place.location, style: const TextStyle(fontWeight: FontWeight.w600)),
                          leading: Image.asset('assets/logos/logo.jpeg'),
                          contentPadding: const EdgeInsets.all(8),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ReviewScreen(placeId: place.id)),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is PlaceError) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text('Some error happened, please check it again', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            );
          }
          return const Center(child: Text('No data available', style: TextStyle(fontWeight: FontWeight.w600)));
        },
      ),
    );
  }
}
