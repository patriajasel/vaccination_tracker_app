class VaccineData {
  final String vaccine;
  final List<Section> sections;

  VaccineData({required this.vaccine, required this.sections});

  factory VaccineData.fromJson(Map<String, dynamic> json) {
    return VaccineData(
      vaccine: json['vaccine'],
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}

class Section {
  final String title;
  final String info;
  final String opening;
  final String ending;
  final List<Bullet> bullets;
  final List<TitledBullet> titledBullets;
  final List<NumberedBullet> numberedBullets;
  final List<MiscFact> miscAndFact;

  Section(
      {required this.title,
      required this.info,
      required this.opening,
      required this.ending,
      required this.bullets,
      required this.titledBullets,
      required this.numberedBullets,
      required this.miscAndFact});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
        title: json['title'] ?? '',
        info: json['info'] ?? '',
        opening: json['opening'] ?? '',
        ending: json['ending'] ?? '',
        bullets: (json['bullets'] as List)
            .map((bullet) => Bullet.fromJson(bullet))
            .toList(),
        titledBullets: (json['titled_bullets'] as List)
            .map((nb) => TitledBullet.fromJson(nb))
            .toList(),
        numberedBullets: (json['numbered_bullets'] as List)
            .map((nb) => NumberedBullet.fromJson(nb))
            .toList(),
        miscAndFact: (json['misc_and_fact'] as List)
            .map((mf) => MiscFact.fromJson(mf))
            .toList());
  }
}

class Bullet {
  final String bulletTitle;
  final String moreInfo;

  Bullet({required this.bulletTitle, required this.moreInfo});

  factory Bullet.fromJson(Map<String, dynamic> json) {
    return Bullet(
      bulletTitle: json['bullet_title'],
      moreInfo: json['more_info'],
    );
  }
}

class TitledBullet {
  final String section;
  final List<String> bullets;

  TitledBullet({required this.section, required this.bullets});

  factory TitledBullet.fromJson(Map<String, dynamic> json) {
    return TitledBullet(
      section: json["section"] ?? '',
      bullets: List<String>.from(json["bullets"] ?? []),
    );
  }
}

class NumberedBullet {
  final String title;
  final List<String> bullets;

  NumberedBullet({required this.title, required this.bullets});

  factory NumberedBullet.fromJson(Map<String, dynamic> json) {
    return NumberedBullet(
      title: json["title"],
      bullets: List<String>.from(json["bullets"]),
    );
  }
}

class MiscFact {
  final List<String> misc;
  final List<String> fact;

  MiscFact({required this.misc, required this.fact});

  factory MiscFact.fromJson(Map<String, dynamic> json) {
    return MiscFact(
      misc: List<String>.from(json["misc"]),
      fact: List<String>.from(json["fact"]),
    );
  }
}
