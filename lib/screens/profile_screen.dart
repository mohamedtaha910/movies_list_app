import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/components/horizintal_line.dart';
import 'package:movies_app/components/profile_row.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:movies_app/cubits/favourite_cubit/favourite_states.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/screens/favourite_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

@override
  void initState() {
    BlocProvider.of<FavCubit>(context).fetchAllFav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        BlocProvider.of<FavCubit>(context).fetchAllFav();
        List<MovieModel>? movies = BlocProvider.of<FavCubit>(context).movies;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        // backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fHww&w=1000&q=80'),
                        backgroundImage: AssetImage('assets/person.jpg'),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mohamed Taha',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kTextColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'movies : ${movies.length}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    // height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(23),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ProfileRow(
                          title: 'Favourite',
                          icon: Icons.bookmark,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    FavouritePage(isInProfile: true),
                              ),
                            );
                          },
                        ),
                        // const SizedBox(height: 8),
                        HorizintalLine(),
        
                        ProfileRow(
                          title: 'Settings',
                          icon: Icons.settings,
                          onTap: () {},
                        ),
        
                        HorizintalLine(),
        
                        ProfileRow(
                          title: 'About',
                          icon: Icons.info_outline,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
        
                  const SizedBox(height: 40),
                  Text(
                    'Personal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    // height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(23),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ProfileRow(
                          title: 'Change Password',
                          icon: Icons.lock,
                          onTap: () {},
                        ),
                        // const SizedBox(height: 8),
                        HorizintalLine(),
        
                        ProfileRow(
                          title: 'Logout',
                          icon: Icons.logout,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
        
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
