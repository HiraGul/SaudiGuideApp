class RecommendationDataModel {
  final String title;
  final List<String> subCategories;

  RecommendationDataModel({
    required this.subCategories,
    required this.title,
  });
}

class RecommendationData {
  static List<RecommendationDataModel> list = [
    RecommendationDataModel(
      subCategories: [
        "Saudi",
        "Turkish",
        "Indian",
        "Seafood",
        "Traditional",
        "Continental",
      ],
      title: 'Food & Drinks',
    ),
    RecommendationDataModel(
      subCategories: [
        "Sports",
        "Arts & Exhibitions",
        "Outdoor Activities",



      ],
      title: 'Entertainments',
    ),
    RecommendationDataModel(
      subCategories: [
        "Hilly Areas",
        "Desert",
        "Beach",
      ],
      title: 'Tourist',
    ),
    RecommendationDataModel(
      subCategories: [
        "Hajj Steps",
        "Hajj Preparation",
        "Hajj Tips",
        "Hajj FAQ'S",
      ],
      title: 'Hajj',
    ),
    RecommendationDataModel(
      subCategories: [
        "Umrah Steps",
        "Umrah Preparation",
        "Umrah Tips",
        "Umrah FAQ'S",
      ],
      title: 'Umrah',
    ),
  ];
}
