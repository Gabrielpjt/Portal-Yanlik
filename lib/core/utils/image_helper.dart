import 'package:flutter/material.dart';

/// Helper untuk loading images dengan error handling
class ImageHelper {
  /// Load image dari assets dengan error handling
  static Widget asset(
    String path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image, color: Colors.grey),
            );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: frame != null
              ? child
              : placeholder ??
                  Container(
                    width: width,
                    height: height,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
        );
      },
    );
  }

  /// Load image dari network dengan caching dan error handling
  static Widget network(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        
        return placeholder ??
            Container(
              width: width,
              height: height,
              color: Colors.grey[200],
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  strokeWidth: 2,
                ),
              ),
            );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image, color: Colors.grey),
            );
      },
    );
  }

  /// Avatar widget dengan fallback ke initial
  static Widget avatar(
    String? imageUrl,
    String name, {
    double size = 40,
  }) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return _buildInitialAvatar(name, size);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorWidget: _buildInitialAvatar(name, size),
      ),
    );
  }

  static Widget _buildInitialAvatar(String name, double size) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.blue[700],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
