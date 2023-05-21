class landMarkModel {
  Description? description;
  String? requestId;
  Metadata? metadata;

  landMarkModel({this.description, this.requestId, this.metadata});

  landMarkModel.fromJson(Map<String, dynamic> json) {
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
    requestId = json['requestId'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    data['requestId'] = this.requestId;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    return data;
  }
}

class Description {
  List<String>? tags;
  List<Captions>? captions;

  Description({this.tags, this.captions});

  Description.fromJson(Map<String, dynamic> json) {
    tags = json['tags'].cast<String>();
    if (json['captions'] != null) {
      captions = <Captions>[];
      json['captions'].forEach((v) {
        captions!.add(new Captions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tags'] = this.tags;
    if (this.captions != null) {
      data['captions'] = this.captions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Captions {
  String? text;
  double? confidence;

  Captions({this.text, this.confidence});

  Captions.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['confidence'] = this.confidence;
    return data;
  }
}

class Metadata {
  int? height;
  int? width;
  String? format;

  Metadata({this.height, this.width, this.format});

  Metadata.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    width = json['width'];
    format = json['format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['width'] = this.width;
    data['format'] = this.format;
    return data;
  }
}
