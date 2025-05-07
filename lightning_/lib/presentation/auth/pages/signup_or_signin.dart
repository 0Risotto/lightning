import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lightning_/common/helpers/is_dark_mode.dart';
import 'package:lightning_/common/widgets/button/basic_app_button.dart';
import 'package:lightning_/core/configs/assets/app_images.dart';
import 'package:lightning_/core/configs/assets/app_vectors.dart';
import 'package:lightning_/core/configs/theme/app_colors.dart';
import 'package:lightning_/presentation/auth/pages/signup.dart';
import 'package:lightning_/presentation/auth/pages/singin.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),



          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBG),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppVectors.logo
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                  Text(
                    'Enjoy Listening to Music',
                    style:TextStyle(  
                    fontWeight: FontWeight.bold,
                    fontSize: 26
                      )
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    Text( 
                    'Lightning is a propietary Audio streaming,\nmusic finding and media service provider',
                    style:TextStyle(  
                    fontSize: 13,
                    color: AppColors.grey
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: BasicAppButton(
                            onPressed: (){
                              Navigator.pushReplacement(
                               context,
                               MaterialPageRoute(builder:(BuildContext context)=> SignupPage() ) 
                               );
                            },
                             title:'Register'
                            ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed:(){
                              Navigator.pushReplacement(
                               context,
                               MaterialPageRoute(builder:(BuildContext context)=> SigninPage() ) 
                               );
                            },
                            child:  Text('Sign in'
                            ,style: TextStyle(
                              
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: context.isDarkMode?Colors.white: Colors.black 
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}