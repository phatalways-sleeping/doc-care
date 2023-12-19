// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/src/absent/receptionist/controller/receptionist_absent_bloc.dart';
import 'package:screens/src/absent/receptionist/doctor_card.dart';
import 'package:screens/src/absent/receptionist/showRequestDialog.dart';
import 'package:screens/src/booking/booking_view/dc_loading_view.dart';

final data = [
  {
    'name': 'John Doe',
    'dateAbsent': DateTime.now(),
    'imgPath': 'https://picsum.photos/200',
    'doctorId': '1',
  },
  {
    'name': 'Jane Doe',
    'dateAbsent': DateTime.now(),
    'imgPath': 'https://picsum.photos/200',
    'doctorId': '2',
  },
  {
    'name': 'Alex Doe',
    'dateAbsent': DateTime.now(),
    'imgPath': 'https://picsum.photos/200',
    'doctorId': '3',
  },
];

class DCReceptionistAbsentScreen extends StatefulWidget {
  const DCReceptionistAbsentScreen({super.key});

  @override
  State<DCReceptionistAbsentScreen> createState() =>
      _DCReceptionistAbsentScreenState();
}

class _DCReceptionistAbsentScreenState
    extends State<DCReceptionistAbsentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ReceptionistAbsentBloc(),
        child: BlocConsumer<ReceptionistAbsentBloc, ReceptionistAbsentState>(
          listener: (context, state) async {
            if (state is ReceptionistAbsentViewState) {
              await showRequestDialog(
                context: context,
                title: 'Absent Request',
                doctorName: 'John Doe',
                absentDate: DateTime.now(),
                messageReasons: 'I have a fever',
                messageNotes: 'I will be back soon',
              ).then(
                (value) {
                  if (value == RequestResponse.accept) {
                    context.read<ReceptionistAbsentBloc>().add(
                          const ReceptionistAbsentResponseEvent(
                            approved: true,
                          ),
                        );
                  } else if (value == RequestResponse.reject) {
                    context.read<ReceptionistAbsentBloc>().add(
                          const ReceptionistAbsentResponseEvent(
                            approved: false,
                          ),
                        );
                  } else {
                    context.read<ReceptionistAbsentBloc>().add(
                          const ReceptionistAbsentResetEvent(),
                        );
                  }
                },
              );
            } else if (state is ReceptionistAbsentErrorState) {}
          },
          builder: (context, state) => Scaffold(
            appBar: const DCReceptionistHeaderBar(
              haveLogout: true,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.03,
                    vertical: context.height * 0.02,
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.width * 0.03,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Requests',
                                style: context.textTheme.h1BoldPoppins.copyWith(
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(width: 8),
                              SvgPicture.string(
                                DCSVGIcons.absentRequest,
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<ReceptionistAbsentBloc,
                            ReceptionistAbsentState>(
                          builder: (context, state) {
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return DoctorCard(
                                  imgPath: data[index]['imgPath']! as String,
                                  name: data[index]['name']! as String,
                                  dateAbsent:
                                      data[index]['dateAbsent']! as DateTime,
                                  onPressed: (context) => context
                                      .read<ReceptionistAbsentBloc>()
                                      .add(
                                        ReceptionistAbsentViewEvent(
                                          doctorId: data[index]['doctorId']!
                                              as String,
                                          date: data[index]['dateAbsent']!
                                              as DateTime,
                                        ),
                                      ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is ReceptionistAbsentLoadingState)
                  const DCLoadingView(),
              ],
            ),
          ),
        ));
  }
}
