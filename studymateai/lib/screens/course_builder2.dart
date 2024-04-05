import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/widgets/course_template_card.dart';
import '/models/course_template.dart';

// Placeholder for HouseDetailsRecord model
// class HouseDetailsRecord {
//   final String image;
//   final String homeName;
//   final double rating;
//   final double price;
//
//   HouseDetailsRecord(this.image, this.homeName, this.rating, this.price);
// }

class CourseBuilderScreen2 extends StatefulWidget {
  const CourseBuilderScreen2({super.key});

  @override
  CourseBuilderScreen2State createState() => CourseBuilderScreen2State();
}

class CourseBuilderScreen2State extends State<CourseBuilderScreen2> {
  // Simulated fetching of course template data
  List<CourseTemplate> fetchCourseTemplates() {
    // Example data - replace with actual data fetching logic
    return [
      CourseTemplate(id: '1', imageUrl: 'https://picsum.photos/200', title: 'Introduction to Flutter', description: 'Learn the basics of Flutter development.', rating: 4.8),
      // Add more CourseTemplate instances here
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Code to unfocus text fields or other interactive elements
      },
      child: Scaffold(
        // Consider replacing FlutterFlowTheme with actual ThemeData or direct color values
        backgroundColor: Colors.white, // Example replacement
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1286&q=80',
                width: double.infinity,
                height: 500.0,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: 500.0,
                decoration: const BoxDecoration(
                  color: Color(0x8D090F13),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Your converted Column content here
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                          child: IconButton(
                            icon: const Icon(Icons.person_outline, color: Colors.white),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
                    child: Text(
                      'Explore top destinations around the world.',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 320.0, 0.0, 0.0),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: 400.0, // Ensures the container has a minimum height
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white, // Adjust color to match your theme
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 16.0),
                    child: Column(
                      children: [
                        const Divider(
                          height: 4.0,
                          thickness: 4.0,
                          indent: 140.0,
                          endIndent: 140.0,
                          color: Color(0xFFE0E3E7),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                          child: Text(
                            'Highest Rated',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              // Adjust the styling to fit your theme
                            ),
                          ),
                        ),
                        Container(
                          height: 300.0, // Adjusted height to prevent overflow
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4, // Your dynamic item count
                            itemBuilder: (BuildContext context, int index) {
                              // Calculate the width to fit the screen
                              final screenWidth = MediaQuery.of(context).size.width;

                              return Container(
                                width: screenWidth, // Set container width to screenWidth
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                                        child: Image.asset(
                                          'assets/images/course_background.png', // Your image
                                          width: screenWidth, // Ensure image width matches container
                                          height: 200.0, // Adjust if necessary
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Home Name here', // Replace with actual data
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                RatingBarIndicator(
                                                  rating: 3.5, // Replace with actual rating
                                                  itemBuilder: (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 16.0,
                                                  direction: Axis.horizontal,
                                                ),
                                                SizedBox(width: 8.0),
                                                Text(
                                                  '3.5', // Replace with actual rating value
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
