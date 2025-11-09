import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_model.freezed.dart';

@Freezed(copyWith: true)
class Budget with _$Budget {
  @override
  final int? budgetId;
  @override
  final String name;
  @override
  final String? description;
  @override
  final int? resetDay;
  @override
  final DateTime startDate;
  @override
  final bool status;
  @override
  final bool isDailySpend;
  @override
  final double totalAmount;
  @override
  final DateTime createdAt;
  @override
  final DateTime? modifiedAt;

  Budget({
    this.budgetId,
    required this.name,
    this.description,
    this.resetDay = 30,
    required this.startDate,
    this.status = true,
    required this.isDailySpend,
    required this.totalAmount,
    required this.createdAt,
    this.modifiedAt,
  });

  int get daysBeforeReset => DateTime.now()
      .add(Duration(days: resetDay!))
      .difference(DateTime.now())
      .inDays;

  DateTime get resetDate => DateTime.now().add(Duration(days: resetDay!));
}
