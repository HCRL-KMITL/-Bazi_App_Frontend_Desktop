//Branch
class Branch {
  final String character;
  final String name;
  final String spelling;
  final int value;

  Branch({
    required this.character,
    required this.name,
    required this.spelling,
    required this.value,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      character: json['character'],
      name: json['name'],
      spelling: json['spelling'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'character': character,
      'name': name,
      'spelling': spelling,
      'value': value,
    };
  }

}

//Pillar
class HourPillar {
  final Branch earthlyBranch;
  final Branch heavenlyStem;

  HourPillar({
    required this.earthlyBranch,
    required this.heavenlyStem,
  });

  factory HourPillar.fromJson(Map<String, dynamic> json) {
    return HourPillar(
      earthlyBranch: Branch.fromJson(json['earthly_branch']),
      heavenlyStem: Branch.fromJson(json['heavenly_stem']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'earthly_branch': earthlyBranch.toJson(),
      'heavenly_stem': heavenlyStem.toJson(),
    };
  }
}

class DayPillar {
  final int day;
  final Branch earthlyBranch;
  final Branch heavenlyStem;

  DayPillar({
    required this.day,
    required this.earthlyBranch,
    required this.heavenlyStem,
  });

  factory DayPillar.fromJson(Map<String, dynamic> json) {
    return DayPillar(
      day: json['day'],
      earthlyBranch: Branch.fromJson(json['earthly_branch']),
      heavenlyStem: Branch.fromJson(json['heavenly_stem']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'earthly_branch': earthlyBranch.toJson(),
      'heavenly_stem': heavenlyStem.toJson(),
    };
  }
}

class MonthPillar {
  final int month;
  final Branch earthlyBranch;
  final Branch heavenlyStem;

  MonthPillar({
    required this.month,
    required this.earthlyBranch,
    required this.heavenlyStem,
  });

  factory MonthPillar.fromJson(Map<String, dynamic> json) {
    return MonthPillar(
      month: json['month'],
      earthlyBranch: Branch.fromJson(json['earthly_branch']),
      heavenlyStem: Branch.fromJson(json['heavenly_stem']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'earthly_branch': earthlyBranch.toJson(),
      'heavenly_stem': heavenlyStem.toJson(),
    };
  }

}

class YearPillar {
  final int year;
  final Branch earthlyBranch;
  final Branch heavenlyStem;

  YearPillar({
    required this.year,
    required this.earthlyBranch,
    required this.heavenlyStem,
  });

  factory YearPillar.fromJson(Map<String, dynamic> json) {
    return YearPillar(
      year: json['year'],
      earthlyBranch: Branch.fromJson(json['earthly_branch']),
      heavenlyStem: Branch.fromJson(json['heavenly_stem']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'earthly_branch': earthlyBranch.toJson(),
      'heavenly_stem': heavenlyStem.toJson(),
    };
  }
}
