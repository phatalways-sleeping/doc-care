import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:model_api/model_api.dart';

part 'prescription_event.dart';
part 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  PrescriptionBloc(
    this.ID,
    this._prescriptionAPIService,
    this._doctorAPIService,
    this._intakeAPIService,
  ) : super(PrescriptionInitial.empty()) {
    on<PrescriptionInitialEvent>(_onPrescriptionInitialEvent);
    on<PrescriptionTapEvent>(_onPrescriptionTapEvent);
    on<MedicineBackEvent>(_onMedicineBackEvent);
  }

  final String ID;
  final SupabasePrescriptionApiService _prescriptionAPIService;
  final SupabaseDoctorApiService _doctorAPIService;
  final SupabaseIntakeAPIService _intakeAPIService;

  void _onPrescriptionInitialEvent(
    PrescriptionInitialEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    try {
      print('ID: $ID');
      final prescriptionID = <String>[];
      final doctorName = <String>[];
      final datePrescribed = <DateTime>[];
      final note = <String>[];
      final done = <bool>[];
      emit(PrescriptionInitial.empty());
      final prescription = await _prescriptionAPIService
          .getAllPrescriptionListByCustomerID(ID)
          .then((value) {
        for (final element in value) {
          prescriptionID.add(element.id);
          doctorName.add(element.doctorID);
          datePrescribed.add(element.datePrescribed);
          note.add(element.note);
          done.add(element.done);
        }
      });

      for (var i = 0; i < doctorName.length; i++) {
        final doctor = await _doctorAPIService
            .getUser(doctorName[i])
            .then((value) => doctorName[i] = value.fullname);
      }

      emit(
        PrescriptionInitial.input(
          prescriptionID: prescriptionID,
          doctorName: doctorName,
          datePrescribed: datePrescribed,
          note: note,
          done: done,
        ),
      );
    } catch (e) {
      return;
    }
  }

  void _onPrescriptionTapEvent(
    PrescriptionTapEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    try {
      final medicineName = <String>[];
      final quantity = <int?>[];
      final toBeTaken = <int?>[];
      final timeOfTheDay = <String?>[];

      emit(
        PrescriptionLoading(
          prescriptionID: state.prescriptionID,
          doctorName: state.doctorName,
          datePrescribed: state.datePrescribed,
          note: state.note,
          done: state.done,
        ),
      );

      print('prescriptionID: ${event.prescriptionID}');
      try {
        final intake = await _intakeAPIService
            .getIntakeListByPrescriptionID(event.prescriptionID)
            .then((value) {
          for (final element in value) {
            medicineName.add(element.medicineName);
            quantity.add(element.quantity);
            toBeTaken.add(element.toBeTaken);
            timeOfTheDay.add(element.timeOfTheDay);
          }
        });
      } catch (e) {
        emit(
          (state as PrescriptionLoading).toggleBackToInitial(),
        );
        return;
      }

      emit(
        MedicineInitial(
          prescriptionID: state.prescriptionID,
          doctorName: state.doctorName,
          datePrescribed: state.datePrescribed,
          note: state.note,
          done: state.done,
          medicineName: medicineName,
          quantity: quantity,
          toBeTaken: toBeTaken,
          timeOfTheDay: timeOfTheDay,
          currentPrescriptionID: event.prescriptionID,
        ),
      );
    } catch (e) {
      return;
    }
  }

  void _onMedicineBackEvent(
    MedicineBackEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    emit(
      PrescriptionInitial.input(
        prescriptionID: state.prescriptionID,
        doctorName: state.doctorName,
        datePrescribed: state.datePrescribed,
        note: state.note,
        done: state.done,
      ),
    );
  }
}
