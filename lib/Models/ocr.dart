class OCRModel {
  String? language;
  double? textAngle;
  String? orientation;
  List<Regions>? regions;

  OCRModel({this.language, this.textAngle, this.orientation, this.regions});

  OCRModel.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    textAngle = json['textAngle'];
    orientation = json['orientation'];
    if (json['regions'] != null) {
      regions = <Regions>[];
      json['regions'].forEach((v) {
        regions!.add(new Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['textAngle'] = this.textAngle;
    data['orientation'] = this.orientation;
    if (this.regions != null) {
      data['regions'] = this.regions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regions {
  String? boundingBox;
  List<Lines>? lines;

  Regions({this.boundingBox, this.lines});

  Regions.fromJson(Map<String, dynamic> json) {
    boundingBox = json['boundingBox'];
    if (json['lines'] != null) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(new Lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boundingBox'] = this.boundingBox;
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? boundingBox;
  List<Words>? words;

  Lines({this.boundingBox, this.words});

  Lines.fromJson(Map<String, dynamic> json) {
    boundingBox = json['boundingBox'];
    if (json['words'] != null) {
      words = <Words>[];
      json['words'].forEach((v) {
        words!.add(new Words.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boundingBox'] = this.boundingBox;
    if (this.words != null) {
      data['words'] = this.words!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Words {
  String? boundingBox;
  String? text;

  Words({this.boundingBox, this.text});

  Words.fromJson(Map<String, dynamic> json) {
    boundingBox = json['boundingBox'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boundingBox'] = this.boundingBox;
    data['text'] = this.text;
    return data;
  }
}
