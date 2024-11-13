import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final String code;
  final String title;

  const Currency({
    required this.code,
    required this.title,
  });

  @override
  List<Object?> get props => [code, title];

  Currency copyWith({
    String? code,
    String? title,
  }) {
    return Currency(
      code: code ?? this.code,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'title': title,
    };
  }

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(code: json.keys.first, title: json.values.first);
  }
}

const Currency emptyCurrency = Currency(
  code: '',
  title: '',
);
