class RoadData {
  final double score;
  final int frameId;
  final RoadOutline roadOutline;
  final List<Coin> coins;

  RoadData({
    required this.score,
    required this.frameId,
    required this.roadOutline,
    required this.coins,
  });

  factory RoadData.fromJson(Map<String, dynamic> json) {
    return RoadData(
      score: json['score'],
      frameId: json['frame_id'],
      roadOutline: RoadOutline.fromJson(json['road_outline']),
      coins: (json['coins'] as List).map((coin) => Coin.fromJson(coin)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'frame_id': frameId,
      'road_outline': roadOutline.toJson(),
      'coins': coins.map((coin) => coin.toJson()).toList(),
    };
  }
}

class RoadOutline {
  final double bottomXR;
  final double bottomXS;
  final double bottomY;
  final double topXR;
  final double topXS;
  final double topY;

  RoadOutline({
    required this.bottomXR,
    required this.bottomXS,
    required this.bottomY,
    required this.topXR,
    required this.topXS,
    required this.topY,
  });

  factory RoadOutline.fromJson(Map<String, dynamic> json) {
    return RoadOutline(
      bottomXR: json['bottom_x_r'],
      bottomXS: json['bottom_x_s'],
      bottomY: json['bottom_y'],
      topXR: json['top_x_r'],
      topXS: json['top_x_s'],
      topY: json['top_y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bottom_x_r': bottomXR,
      'bottom_x_s': bottomXS,
      'bottom_y': bottomY,
      'top_x_r': topXR,
      'top_x_s': topXS,
      'top_y': topY,
    };
  }
}

class Coin {
  final double x;
  final double y;
  final double r;

  Coin({
    required this.x,
    required this.y,
    required this.r,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      x: json['x'],
      y: json['y'],
      r: json['r'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'r': r,
    };
  }
}
