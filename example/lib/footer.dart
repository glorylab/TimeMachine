import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GloryFooter extends StatelessWidget {
  const GloryFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            'icons/ic_glory_lab.png',
            package: 'web3_icons',
            width: 32.0,
            height: 32.0,
          ),
          const SizedBox(height: 8),
          Text(
            'Made in Glory Lab',
            style: GoogleFonts.robotoMono(
              color: Colors.grey[500],
            ),
          )
        ],
      ),
    );
  }
}
