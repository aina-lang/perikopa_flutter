class Verse {
  final String shortName;
  final int toko;
  final int andininyStart;
  final int? andininyEnd;

  Verse({
    required this.shortName,
    required this.toko,
    required this.andininyStart,
    this.andininyEnd,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      shortName: json['shortName'],
      toko: json['toko'],
      andininyStart: json['andininyStart'],
      andininyEnd: json['andininyEnd'],
    );
  }
}

class Perikopa {
  final String date;
  final List<Verse> verset;

  Perikopa({
    required this.date,
    required this.verset,
  });

  factory Perikopa.fromJson(Map<String, dynamic> json) {
    List<dynamic> versetList = json['verset'];
    List<Verse> verses = versetList.map((e) => Verse.fromJson(e)).toList();

    return Perikopa(
      date: json['date'],
      verset: verses,
    );
  }
}

class Month {
  final int id;
  final String nom;
  final String faneva;
  final List<Perikopa> perikopa;

  Month({
    required this.id,
    required this.nom,
    required this.faneva,
    required this.perikopa,
  });

  factory Month.fromJson(Map<String, dynamic> json) {
    List<dynamic> perikopaList = json['perikopa'];
    List<Perikopa> perikopas =
        perikopaList.map((e) => Perikopa.fromJson(e)).toList();

    return Month(
      id: json['id'] ?? 0,
      nom: json['nom'] ?? '',
      faneva: json['faneva'] ?? '',
      perikopa: perikopas,
    );
  }
}

class DataModel {
  final int taona;
  final String tenyFaneva;
  final VerseFaneva versefaneva;
  final Tronche tronche1; // ou supprimez si vous n'avez pas besoin
  final Tronche tronche2; // ou supprimez si vous n'avez pas besoin

  DataModel({
    required this.taona,
    required this.tenyFaneva,
    required this.versefaneva,
    required this.tronche1,
    required this.tronche2,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      taona: json['taona'],
      tenyFaneva: json['tenyFaneva'],
      versefaneva: VerseFaneva.fromJson(json['versefaneva']),
      tronche1: Tronche.fromJson(json['tronche1']),
      tronche2: Tronche.fromJson(json['tronche2']),
    );
  }
}

class VerseFaneva {
  final String shortName;
  final int toko;
  final int andininy;

  VerseFaneva({
    required this.shortName,
    required this.toko,
    required this.andininy,
  });

  factory VerseFaneva.fromJson(Map<String, dynamic> json) {
    return VerseFaneva(
      shortName: json['shortName'],
      toko: json['toko'],
      andininy: json['andininy'],
    );
  }
}

class Tronche {
  final String faneva;
  final List<Month> mois;

  Tronche({
    required this.faneva,
    required this.mois,
  });

  factory Tronche.fromJson(Map<String, dynamic> json) {
    List<dynamic> moisList = json['mois'];
    List<Month> months = moisList.map((e) => Month.fromJson(e)).toList();

    return Tronche(
      faneva: json['faneva'],
      mois: months,
    );
  }
}
