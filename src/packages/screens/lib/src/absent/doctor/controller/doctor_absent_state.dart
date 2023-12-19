// ignore_for_file: public_member_api_docs

part of 'doctor_absent_bloc.dart';

@immutable
sealed class DoctorAbsentState extends Equatable {
  const DoctorAbsentState({
    this.date = '',
    this.reasons = '',
    this.agreeTerms = false,
    this.arrangeAnotherDoctor = false,
  });

  final String date;
  final String reasons;
  final bool agreeTerms;
  final bool arrangeAnotherDoctor;

  @override
  List<Object?> get props => [date, reasons, agreeTerms, arrangeAnotherDoctor];

  DoctorAbsentState copyWith({
    String? date,
    String? reasons,
    bool? agreeTerms,
    bool? arrangeAnotherDoctor,
  });
}

final class DoctorAbsentInitial extends DoctorAbsentState {
  const DoctorAbsentInitial({
    super.date = '',
    super.reasons = '',
    super.agreeTerms = false,
    super.arrangeAnotherDoctor = false,
  });

  factory DoctorAbsentInitial.fromState({
    required DoctorAbsentState state,
  }) =>
      DoctorAbsentInitial(
        date: state.date,
        reasons: state.reasons,
        agreeTerms: state.agreeTerms,
        arrangeAnotherDoctor: state.arrangeAnotherDoctor,
      );

  @override
  DoctorAbsentState copyWith({
    String? date,
    String? reasons,
    bool? agreeTerms,
    bool? arrangeAnotherDoctor,
  }) {
    return DoctorAbsentInitial(
      date: date ?? this.date,
      reasons: reasons ?? this.reasons,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      arrangeAnotherDoctor: arrangeAnotherDoctor ?? this.arrangeAnotherDoctor,
    );
  }
}

final class DoctorAbsentLoading extends DoctorAbsentState {
  const DoctorAbsentLoading({
    super.date = '',
    super.reasons = '',
    super.agreeTerms = false,
    super.arrangeAnotherDoctor = false,
  });

  factory DoctorAbsentLoading.fromState({
    required DoctorAbsentState state,
  }) =>
      DoctorAbsentLoading(
        date: state.date,
        reasons: state.reasons,
        agreeTerms: state.agreeTerms,
        arrangeAnotherDoctor: state.arrangeAnotherDoctor,
      );

  @override
  DoctorAbsentState copyWith({
    String? date,
    String? reasons,
    bool? agreeTerms,
    bool? arrangeAnotherDoctor,
  }) {
    return DoctorAbsentLoading(
      date: date ?? this.date,
      reasons: reasons ?? this.reasons,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      arrangeAnotherDoctor: arrangeAnotherDoctor ?? this.arrangeAnotherDoctor,
    );
  }
}

final class DoctorAbsentSuccess extends DoctorAbsentState {
  const DoctorAbsentSuccess({
    super.date = '',
    super.reasons = '',
    super.agreeTerms = false,
    super.arrangeAnotherDoctor = false,
  });

  @override
  DoctorAbsentState copyWith({
    String? date,
    String? reasons,
    bool? agreeTerms,
    bool? arrangeAnotherDoctor,
  }) {
    return DoctorAbsentSuccess(
      date: date ?? this.date,
      reasons: reasons ?? this.reasons,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      arrangeAnotherDoctor: arrangeAnotherDoctor ?? this.arrangeAnotherDoctor,
    );
  }
}

final class DoctorAbsentError extends DoctorAbsentState {
  const DoctorAbsentError({
    super.date = '',
    super.reasons = '',
    super.agreeTerms = false,
    super.arrangeAnotherDoctor = false,
    required this.errorMessage,
  });

  factory DoctorAbsentError.fromState({
    required DoctorAbsentState state,
    required String errorMessage,
  }) =>
      DoctorAbsentError(
        date: state.date,
        reasons: state.reasons,
        agreeTerms: state.agreeTerms,
        arrangeAnotherDoctor: state.arrangeAnotherDoctor,
        errorMessage: errorMessage,
      );

  final String errorMessage;

  @override
  DoctorAbsentState copyWith({
    String? date,
    String? reasons,
    String? errorMessage,
    bool? agreeTerms,
    bool? arrangeAnotherDoctor,
  }) {
    return DoctorAbsentError(
      date: date ?? this.date,
      reasons: reasons ?? this.reasons,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      arrangeAnotherDoctor: arrangeAnotherDoctor ?? this.arrangeAnotherDoctor,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
