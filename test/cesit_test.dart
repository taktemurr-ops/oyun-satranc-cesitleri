import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_satranc_cesitleri/oyun_satranc_cesitleri.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('10 çeşit, kimlikler benzersiz, 33 dil', () {
    expect(satrancCesitConfigs.length, 10);
    expect(satrancCesitConfigs.map((c) => c.gameId).toSet().length, 10);
    expect(satrancCesitGroup.title.length, 33);
    expect(satrancCesitGroup.tagline.length, 33);
    for (final c in satrancCesitConfigs) {
      expect(c.title.length, 33);
      expect(c.tagline.length, 33);
      for (final s in c.tutorial) {
        expect(s.text.length, 33);
      }
    }
  });

  for (final rules in satrancCesitRules) {
    test('${rules.gameId}: bölümler üretilir ve doğrulanır', () {
      final planner = LevelPlanner(gameId: rules.gameId, optionalMechanics: const []);
      for (final lv in [1, 300, 12345, 49999]) {
        final gl = rules.build(planner.spec(lv));
        expect(gl.validation.ok, isTrue, reason: '${rules.gameId} $lv');
      }
    }, timeout: const Timeout(Duration(minutes: 10)));
  }
}
