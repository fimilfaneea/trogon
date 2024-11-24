import 'package:flutter/material.dart';
import 'package:trogon/presentation/screens/modules_page.dart';

/// A widget that displays a subject tile with an image, title, and description.
/// The description can be toggled to show or hide with an animated transition.
class SubjectTile extends StatefulWidget {
  // The URL for the subject's image asset.
  final String imageUrl;
  // The unique identifier for the subject.
  final String subjectId;
  // The title of the subject.
  final String subjectTitle;
  // A brief description of the subject.
  final String subjectDescription;

  const SubjectTile({
    super.key,
    required this.imageUrl,
    required this.subjectId,
    required this.subjectTitle,
    required this.subjectDescription,
  });

  @override
  SubjectTileState createState() => SubjectTileState();
}

class SubjectTileState extends State<SubjectTile>
    with SingleTickerProviderStateMixin {
  // Animation controller for handling the description's slide-in and slide-out animation.
  late AnimationController _animationController;
  // The slide animation that will be applied to the description overlay.
  late Animation<Offset> _slideAnimation;
  // A flag to track whether the description is visible or hidden.
  bool _isDescriptionVisible = false;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller with a duration of 300 milliseconds.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Define the slide animation, where the description will slide in from the bottom.
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from below the screen
      end: Offset.zero, // End at the normal position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  /// Toggles the visibility of the description. 
  /// If visible, the description slides in, otherwise it slides out.
  void _toggleDescription() {
    setState(() {
      _isDescriptionVisible = !_isDescriptionVisible;
    });

    // Trigger the animation depending on the visibility state of the description.
    if (_isDescriptionVisible) {
      _animationController.forward(); // Slide in
    } else {
      _animationController.reverse(); // Slide out
    }
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is destroyed.
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Generate the asset image path using the subject title (e.g., 'assets/Math.jpg').
    String assetImagePath = 'assets/${widget.subjectTitle}.jpg';
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 150,
              child: GestureDetector(
                // When the user taps on the tile, navigate to the ModulesPage.
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModulesPage(
                        subjectId: widget.subjectId,
                        subjectTitle: widget.subjectTitle,
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    // Background image positioned to fill the entire tile.
                    Positioned.fill(
                      child: SizedBox(
                        height: 1000,
                        width: 200,
                        child: Image.asset(
                          assetImagePath,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    // Title text at the bottom center of the image.
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Text(
                        widget.subjectTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1), 
                              blurRadius: 5,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Info button positioned at the top right to toggle the description.
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          _isDescriptionVisible
                              ? Icons.close
                              : Icons.info_outline,
                          color: Colors.white,
                        ),
                        onPressed: _toggleDescription,
                      ),
                    ),
                    // Animated description overlay that slides in/out.
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          color: Colors.black.withOpacity(0.8),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.subjectDescription,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
