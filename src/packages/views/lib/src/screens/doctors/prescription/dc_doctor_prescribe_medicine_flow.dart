// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utility/utility.dart';
import 'package:views/src/screens/doctors/prescription/controller/prescription_bloc.dart';
import 'package:views/src/screens/doctors/prescription/dc_add_medicine_screen.dart';
import 'package:views/src/screens/doctors/prescription/dc_medical_stat_screen.dart';
import 'package:views/src/screens/doctors/prescription/dc_prescription_screen.dart';

class DCDoctorPrescibeMedicineFlow extends StatefulWidget {
  const DCDoctorPrescibeMedicineFlow({
    required this.navigatorKey,
    required this.customerName,
    super.key,
  });

  final String customerName;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<DCDoctorPrescibeMedicineFlow> createState() =>
      _DCDoctorPrescibeMedicineFlowState();
}

class _DCDoctorPrescibeMedicineFlowState
    extends State<DCDoctorPrescibeMedicineFlow> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrescriptionBloc(
        widget.navigatorKey,
        NotificationManager.instance,
        Supabase.instance.client,
      ),
      child: BlocConsumer<PrescriptionBloc, PrescriptionState>(
        listener: (context, state) {
          if (state is PrescriptionMedicalInitial) {
            BlocProvider.of<PrescriptionBloc>(context).add(
              const RetrieveMedicineEvent(),
            );
          }
        },
        builder: (context, state) {
          if (state is PrescriptionMedicalLoading) {
            BlocProvider.of<PrescriptionBloc>(context).add(
              const RetrieveMedicineEvent(),
            );
          }
          final screen = state is PrescriptionMedicalLoading
              ? const Center(child: CircularProgressIndicator())
              : state is PrescriptionMedicalInitial
                  ? DCMedicalStatScreen(customerName: widget.customerName)
                  : state is PrescriptionMedicalSuccess
                      ? DCPrescriptionScreen(customerName: widget.customerName)
                      : state is PrescriptionAddMedicine
                          ? const DCAddMedicineScreen()
                          : state is PrescriptionSuccess
                              ? Container()
                              : Container();
          return Scaffold(
            key: widget.navigatorKey,
            resizeToAvoidBottomInset: true,
            appBar: DCDoctorHeaderBar(
              title: '',
              allowNavigateBack: true,
              onLeadingIconPressed: (context) {
                BlocProvider.of<PrescriptionBloc>(context).add(
                  const PrescriptionBackEvent(),
                );
              },
            ),
            body: GestureDetector(
              onTap: FocusScope.of(context).unfocus,
              child: screen,
            ),
          );
        },
      ),
    );
  }
}
