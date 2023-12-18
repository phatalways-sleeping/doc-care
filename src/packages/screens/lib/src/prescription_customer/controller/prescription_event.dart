part of 'prescription_bloc.dart';

@immutable
sealed class PrescriptionEvent extends Equatable {
  const PrescriptionEvent();

  @override
  List<Object?> get props => [];
}

final class PrescriptionInitialEvent extends PrescriptionEvent {
  const PrescriptionInitialEvent();

  @override
  List<Object?> get props => [];
}

final class PrescriptionTapEvent extends PrescriptionEvent {
  const PrescriptionTapEvent(this.prescriptionID, this.index);

  final String prescriptionID;
  final int index;

  @override
  List<Object?> get props => [prescriptionID];
}

final class MedicineBackEvent extends PrescriptionEvent {
  const MedicineBackEvent();

  @override
  List<Object?> get props => [];
}