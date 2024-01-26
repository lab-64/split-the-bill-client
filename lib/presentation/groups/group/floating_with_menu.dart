import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingWithMenu extends StatefulWidget {
  const FloatingWithMenu({super.key});

  @override
  State<FloatingWithMenu> createState() => _FloatingWithMenuState();
}

class _FloatingWithMenuState extends State<FloatingWithMenu> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade400,
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      spacing: 12,
      spaceBetweenChildren: 8,
      children: [
        _buildSpeedDialChild(
          icon: Icons.attach_money,
          label: "Pay",
          backgroundColor: Colors.green.shade400,
        ),
        _buildSpeedDialChild(
          icon: Icons.group_add,
          label: "New Member",
          backgroundColor: Colors.orange.shade400,
        ),
        _buildSpeedDialChild(
          icon: Icons.add_shopping_cart,
          label: "New Bill",
          backgroundColor: Colors.pink.shade400,
        ),
      ],
    );
  }

  SpeedDialChild _buildSpeedDialChild({
    required IconData icon,
    required String label,
    required Color backgroundColor,
  }) {
    return SpeedDialChild(
      child: Icon(icon),
      label: label,
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      labelBackgroundColor: Colors.blue.shade400,
      labelStyle: const TextStyle(color: Colors.white),
      shape: const CircleBorder(),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Not implemented yet'),
          ),
        );
      },
    );
  }
}
