import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  final double height;
  final Duration autoScrollDuration;
  final Duration transitionDuration;
  final BorderRadius? borderRadius;
  final bool showArrows;
  final bool autoScroll;

  const ImageCarousel({
    super.key,
    required this.images,
    this.height = 160,
    this.autoScrollDuration = const Duration(seconds: 4),
    this.transitionDuration = const Duration(milliseconds: 500),
    this.borderRadius,
    this.showArrows = true,
    this.autoScroll = true,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (widget.autoScroll) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    Future.delayed(widget.autoScrollDuration, () {
      if (mounted && widget.images.isNotEmpty) {
        int nextIndex = (_currentIndex + 1) % widget.images.length;
        _pageController.animateToPage(
          nextIndex,
          duration: widget.transitionDuration,
          curve: Curves.easeInOut,
        );
        if (widget.autoScroll) {
          _startAutoScroll();
        }
      }
    });
  }

  void _navigateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return _buildEmptyState();
    }

    return Stack(
      children: [

        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return _buildCarouselItem(index);
            },
          ),
        ),


        _buildGradientOverlay(),

        // Dot Indicators
        _buildDotIndicators(),


        if (widget.showArrows) ...[
          _buildLeftArrow(),
          _buildRightArrow(),
        ],
      ],
    );
  }

  Widget _buildCarouselItem(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
      ),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: Image.asset(
          widget.images[index],
          height: widget.height,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallbackGradient(index);
          },
        ),
      ),
    );
  }

  Widget _buildFallbackGradient(int index) {
    final List<List<Color>> gradientOptions = [
      [Colors.pink.shade200, Colors.purple.shade300, Colors.blue.shade200],
      [Colors.orange.shade200, Colors.red.shade300, Colors.pink.shade200],
      [Colors.blue.shade200, Colors.teal.shade300, Colors.green.shade200],
      [Colors.purple.shade200, Colors.indigo.shade300, Colors.blue.shade200],
      [Colors.green.shade200, Colors.lime.shade300, Colors.yellow.shade200],
    ];

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientOptions[index % gradientOptions.length],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
              size: 40,
              color: Colors.white.withOpacity(0.8),
            ),
            const SizedBox(height: 8),
            Text(
              'Image ${index + 1}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.3),
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicators() {
    return Positioned(
      bottom: 15,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.images.length,
          (index) => GestureDetector(
            onTap: () => _navigateToPage(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentIndex == index ? 24 : 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentIndex == index
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftArrow() {
    return Positioned(
      left: 10,
      top: 0,
      bottom: 0,
      child: Center(
        child: GestureDetector(
          onTap: () {
            int prevIndex = (_currentIndex - 1 + widget.images.length) % widget.images.length;
            _navigateToPage(prevIndex);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRightArrow() {
    return Positioned(
      right: 10,
      top: 0,
      bottom: 0,
      child: Center(
        child: GestureDetector(
          onTap: () {
            int nextIndex = (_currentIndex + 1) % widget.images.length;
            _navigateToPage(nextIndex);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade400,
          ],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              size: 40,
              color: Colors.white70,
            ),
            SizedBox(height: 8),
            Text(
              'No Images',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

