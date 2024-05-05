import 'package:flutter/material.dart';

class ImageDialog {
  static ImageDialogState of(BuildContext context) {
    return ImageDialogState(context);
  }
}

class ImageDialogState {
  ImageDialogState(this.context);

  final BuildContext context;

  void showImageNetworkDialog(String imageUrlPath) {
    showDialog(
      context: context,
      barrierColor:
          Colors.black.withOpacity(0.9), // Semi-transparent black background
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.1),
          body: Stack(
            children: <Widget>[
              Center(
                child: InteractiveViewer(
                    panEnabled: false, // Disable panning
                    boundaryMargin: const EdgeInsets.all(20),
                    minScale: 0.5,
                    maxScale: 4,
                    child: Image.network(
                      imageUrlPath,
                      fit: BoxFit.fitWidth,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showImageAssetDialog(String imageAssetPath) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor:
          Colors.black.withOpacity(0.9), // Black and opaque background
      builder: (BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.1),
            body: Stack(
              children: <Widget>[
                Center(
                  // Center the InteractiveViewer
                  child: InteractiveViewer(
                    panEnabled: false, // Disable panning
                    boundaryMargin: const EdgeInsets.all(20),
                    minScale: 0.5,
                    maxScale: 4,
                    child: Image.asset(
                      imageAssetPath,
                      fit: BoxFit.contain, // Ensure the entire image is visible
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ));
      },
    );
  }
}
