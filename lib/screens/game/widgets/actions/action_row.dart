import 'package:flutter/material.dart';
import 'package:letamind/screens/game/utils/size_data.dart';

class ActionRow extends StatelessWidget {
  const ActionRow({
    @required this.icon1,
    @required this.color1,
    @required this.onTap1,
    @required this.icon2,
    @required this.color2,
    @required this.onTap2,
    @required this.sizeData,
  });
  final Icon icon1;
  final Color color1;
  final GestureTapCallback onTap1;
  final Icon icon2;
  final Color color2;
  final GestureTapCallback onTap2;
  final SizeData sizeData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionButton(
          sizeData: sizeData,
          color: color1,
          icon: icon1,
          onTap: onTap1,
        ),
        SizedBox(width: sizeData.padding * 2),
        _ActionButton(
          sizeData: sizeData,
          color: color2,
          icon: icon2,
          onTap: onTap2,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    @required this.sizeData,
    @required this.color,
    @required this.icon,
    @required this.onTap,
  });
  final SizeData sizeData;
  final Color color;
  final Icon icon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: sizeData.size,
        height: sizeData.size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(child: icon),
      ),
    );
  }
}
