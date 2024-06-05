// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/user_model.dart';
import 'package:loyalty_system_mobile/data/repository/profile_repo.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/logic/pofile/bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.sizeOf(context).height;
    final _width = MediaQuery.sizeOf(context).width;
    final roleID = CacheManager.getUserModel()!.roleID;
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(
        ProfileRepository(
          externalService: ExternalService(),
        ),
      )..add(
          GetProfileDataEvent(),
        ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileloaddedState) {
              User user = state.user;
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.appBarColor,
                          AppColors.green,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                      ),
                    ),
                  ),
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            user.name.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _height / 2.2),
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: _height / 2.6,
                              left: _width / 20,
                              right: _width / 20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 2.0,
                                          offset: Offset(0.0, 2.0))
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.all(_width / 20),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        headerChild('Points', user.points),
                                        roleID == 4
                                            ? headerChild(
                                                'Special Points',
                                                user.spicialPoins,
                                              )
                                            : const Center()
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: _height / 20),
                                child: Column(
                                  children: <Widget>[
                                    infoChild(_width, Icons.email, user.email),
                                    infoChild(_width, Icons.call, user.phone),
                                    roleID == 5
                                        ? infoChild(_width, Icons.location_on,
                                            user.location)
                                        : const Center(),
                                    roleID == 5
                                        ? infoChild(_width, Icons.description,
                                            user.about)
                                        : const Center()
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is ProfileFaildState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget headerChild(String header, var value) => Expanded(
        child: Column(
      children: <Widget>[
        Text(
          header,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          '$value',
          style: GoogleFonts.montserrat(
              fontSize: 20,
              color: AppColors.green,
              fontWeight: FontWeight.bold),
        )
      ],
    ));

Widget infoChild(double width, IconData icon, data) => Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: width / 10,
            ),
            Icon(
              icon,
              color: AppColors.pointCardColor,
              size: 36.0,
            ),
            SizedBox(
              width: width / 20,
            ),
            Text(data)
          ],
        ),
        onTap: () {
          print('Info Object selected');
        },
      ),
    );
