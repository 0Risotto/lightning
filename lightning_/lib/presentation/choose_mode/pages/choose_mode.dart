import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lightning_/common/widgets/button/basic_app_button.dart';
import 'package:lightning_/core/configs/assets/app_images.dart';
import 'package:lightning_/core/configs/assets/app_vectors.dart';
import 'package:lightning_/core/configs/theme/app_colors.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Stack(
        children: [
          Container( padding: EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 40
          ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.chooseModeBG
                ),
                fit: BoxFit.fill
                )
            ),
          
          ),
          
          
          
          Container(
            color: Colors.black.withOpacity(0.15),
          ),


          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo)),
                Spacer(),
                Text(
                  'Choose Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18
                  ),
                ),
                SizedBox(height: 50,),
                 
                 //sun and moon 
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                      
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff30393C).withOpacity(0.5),
                        
                          ),
                        
                        ),
                      ),
                    ),
                    SizedBox(width: 40,),
                    
                    ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                      
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff30393C).withOpacity(0.5),
                        
                          ),
                        
                        ),
                      ),
                    )
                  
                  ],

                 ),

                SizedBox(height: 50,),
                BasicAppButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:(BuildContext context) => const ChooseModePage()
                        )
                       );
                  },
                   title: 'Get Started'
                   ),
              ],
            ),
          ),
        ],
      ), 
    );
  }
}