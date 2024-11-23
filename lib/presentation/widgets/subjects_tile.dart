import 'package:flutter/material.dart';
import 'package:trogon/presentation/screens/modules_page.dart';

class SubjectTile extends StatefulWidget {
  final String imageUrl;
  final String subjectId;
  final String subjectTitle;
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
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isDescriptionVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void _toggleDescription() {
    setState(() {
      _isDescriptionVisible = !_isDescriptionVisible;
    });

    if (_isDescriptionVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 100,
              child: GestureDetector(
                onTap: () {
                  // On tap, navigate to the ModulesPage
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
                    // Background image
                    Positioned.fill(
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Info button
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
                    // Animated description overlay
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
