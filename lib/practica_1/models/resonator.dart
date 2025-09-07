class Resonator {
  final String name;
  final String image;
  final double atk;
  final double hp;
  final double def;
  final double? critRate;
  final double? critDmg;

  Resonator({
    required this.name,
    required this.image,
    required this.atk,
    required this.hp,
    required this.def,
    this.critRate,
    this.critDmg
  });
}
