import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Phosphor 글리프 매핑 (디자인 규칙: 아이콘은 phosphor_flutter만).
/// phosphor_flutter ^2.1.0 기준. API 변경 시 이 파일만 고치면 됨.
class AppIcons {
  AppIcons._();
  static IconData vinylFill = PhosphorIcons.vinylRecord(PhosphorIconsStyle.fill);
  static IconData house = PhosphorIcons.house();
  static IconData houseFill = PhosphorIcons.house(PhosphorIconsStyle.fill);
  static IconData search = PhosphorIcons.magnifyingGlass();
  static IconData scan = PhosphorIcons.scan();
  static IconData user = PhosphorIcons.user();
  static IconData bell = PhosphorIcons.bellSimple();
  static IconData sparkleFill = PhosphorIcons.sparkle(PhosphorIconsStyle.fill);
  static IconData fireFill = PhosphorIcons.fire(PhosphorIconsStyle.fill);
  static IconData musicNotes = PhosphorIcons.musicNotes();
  static IconData arrowLeft = PhosphorIcons.arrowLeft();
  static IconData x = PhosphorIcons.x();
  static IconData xCircle = PhosphorIcons.xCircle();
  static IconData lightning = PhosphorIcons.lightning();
  static IconData keyboard = PhosphorIcons.keyboard();
  static IconData checkCircle = PhosphorIcons.checkCircle();
  static IconData checkCircleFill = PhosphorIcons.checkCircle(PhosphorIconsStyle.fill);
  static IconData shareNetwork = PhosphorIcons.shareNetwork();
  static IconData dotsThree = PhosphorIcons.dotsThreeOutline();
  static IconData playFill = PhosphorIcons.play(PhosphorIconsStyle.fill);
  static IconData caretDown = PhosphorIcons.caretDown();
  static IconData caretRight = PhosphorIcons.caretRight();
  static IconData star = PhosphorIcons.star();
  static IconData starFill = PhosphorIcons.star(PhosphorIconsStyle.fill);
  static IconData starHalf = PhosphorIcons.starHalf(PhosphorIconsStyle.fill);
  static IconData heart = PhosphorIcons.heartStraight();
  static IconData heartFill = PhosphorIcons.heartStraight(PhosphorIconsStyle.fill);
  static IconData pencil = PhosphorIcons.pencilSimpleLine();
  static IconData chatCircleFill = PhosphorIcons.chatCircle(PhosphorIconsStyle.fill);
  static IconData gear = PhosphorIcons.gearSix();
}
