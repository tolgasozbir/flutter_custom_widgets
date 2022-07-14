part of './clipped_button.dart';

class CustomButtonClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.cubicTo(
      size.width*0.12166, 
      size.height*0.79666, 
      size.width*0.99666,
      size.height*0.78333, 
      size.width*0.99833,
      size.height*0.46933, 
    );
    path.cubicTo(
      size.width*0.94000,
      size.height*0.20099, 
      size.width*0.23666,
      size.height*0.19866, 
      0, 
      0
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomButtonClip oldClipper) => false;

}

// Path getClip(Size size) {
//     final path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(0, size.height);
//     path.cubicTo(
//       size.width*0.066, 
//       size.height*0.775, 
//       size.width*0.36,
//       size.height*0.73, 
//       size.width*0.37, 
//       size.height*0.50
//     );
//     path.cubicTo(
//       size.width*0.375,
//       size.height*0.205, 
//       size.width*0.032,
//       size.height*0.183, 
//       0, 
//       0
//     );
//     path.close();


/*
    path.cubicTo(
      7.3, 
      119.5, 
      59.8,
      117.5, 
      59.9, 
      70.4
    );
    path.cubicTo(
      56.4,
      30.15, 
      14.2,
      29.8, 
      0, 
      0
    );
*/