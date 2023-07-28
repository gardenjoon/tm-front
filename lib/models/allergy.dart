class AllergySet {
  int? allergy_set_id;
  String? allergy_set_name;
  List<Allergy>? allergy_infos;

  AllergySet({
    this.allergy_set_id,
    this.allergy_set_name,
    this.allergy_infos,
  });

  AllergySet.fromJson(Map<dynamic, dynamic> json)
      : allergy_set_id = json['algySetId'],
        allergy_set_name = json['algySetNm'],
        allergy_infos = json['allergyInfos'];
}

class Allergy {
  final int? allergy_id;
  final int? allergy_sequence_number;
  final String? allergy_name;

  Allergy({
    this.allergy_id,
    this.allergy_sequence_number,
    this.allergy_name,
  });

  Allergy.fromJson(Map<dynamic, dynamic> json)
      : allergy_id = json['algyId'],
        allergy_sequence_number = json['algySqno'],
        allergy_name = json['algyNm'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['allergy_id'] = allergy_id;
    data['allergy_sequence_number'] = allergy_sequence_number;
    data['allergy_name'] = allergy_name;

    return data;
  }
}
