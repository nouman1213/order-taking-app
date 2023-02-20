import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.020, vertical: height * 0.020),
        child: Column(
          children: [
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.015),

                    Center(
                        child: Image.asset(
                      "assets/images/sacrletlogo.png",
                      width: width * 0.6,
                      // height: 320,
                    )),
                    // SizedBox(height: 20),
                    Center(
                        child: Image.asset(
                      "assets/images/aboutus.png",
                      width: width * 0.6,

                      // height: 320,
                    )),
                    Text(
                      "SCARLET-Order Management application is designed to facilitate its users regarding order management operations, Collection, receipts from customer.There is restricted use of this application and only for the authorized personnes 1 of Saif Brothers.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: height * 0.025,
                          color: Theme.of(context).colorScheme.outline),
                    ),
                    SizedBox(height: height * 0.015),

                    Center(
                      child: Text(
                        "Version 1.0.0 \nReleased on Feb 14, 2023",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: height * 0.025,
                            color: Theme.of(context).colorScheme.outline),
                      ),
                    ),
                    // Spacer(),
                  ]),
            ),
            Center(
              child: Text(
                "Copyright SCARLET IT Systems (Pvt) Limited",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: height * 0.020,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
