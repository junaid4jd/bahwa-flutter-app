import 'package:bahwa_flutter_app/res/colors.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final String route;

  const AppBackButton({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap:() {
        print('tapping to remove');
        Navigator.pushNamed(context, route, );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          alignment: Alignment.centerLeft,
          width: size.width*0.95,
          child: IconButton(onPressed: (){
            print('tapping to remove');
            Navigator.pushNamed(context, route, );

            //Navigator.of(context).pop();

          }, icon: Icon(Icons.arrow_back, color: AppColors.darkRedColor,size: 20,)),

        ),
      ),
    );
  }
}
