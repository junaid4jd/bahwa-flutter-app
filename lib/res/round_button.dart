import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/res/colors.dart';
import 'package:flutter/material.dart';


class RoundButton extends StatelessWidget {

  final String title;
  final bool isLoading;
  final VoidCallback onPress;

  const RoundButton({super.key, required this.title,  this.isLoading = false, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
      isLoading
          ? Center(
          child: CircularProgressIndicator(
            color: darkRedColor,
            strokeWidth: 1,
          ))
          :
      Padding(
      padding: const EdgeInsets.only(
          left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 5.0)
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [
              AppColors.darkRedColor,
              lightRedColor,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10.0),
                ),
              ),
              minimumSize:
              MaterialStateProperty.all(
                  Size(size.width, 50)),
              backgroundColor:
              MaterialStateProperty.all(
                  Colors.transparent),
              // elevation: MaterialStateProperty.all(3),
              shadowColor:
              MaterialStateProperty.all(
                  Colors.transparent),
            ),
            onPressed: onPress,
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
