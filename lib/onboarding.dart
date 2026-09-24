import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      done: Text('Done'),
      onDone: () => context.go('/'),
      // overrideNext: (context, onPressed) {
      //   return ;
      // },
      next: Text('Next'),
      // next: TextButton(onPressed: (){}, child: child),
      // overrideNext: (context, ),
      // rawPages: [
      //   PageView(
      //   )
      // ],
      pages: [
        PageViewModel(
          title: 'Welcome to Flutter 2 Class',
          useScrollView: true,
          // titleWidget: Icon(Icons.phone),
          body: 'This is an example of onboarding screen',
          image: Center(
            child: ColorFiltered(
              child: Image.asset('lib/erikawittlieb-house-2414374_1280.jpg'),
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.8),
                BlendMode.screen,
              ),
            ),
          ),
          decoration: PageDecoration(
            fullScreen: true,
            safeArea: 60,
            titleTextStyle: TextStyle(color: Colors.green, fontSize: 30),
          ),
        ),
        PageViewModel(
          title: 'This is Page 1',
          useScrollView: true,
          // titleWidget: Icon(Icons.phone),
          body: 'This is an example of onboarding screen',
          image: Center(
            child: Image.asset('lib/kaboompics-old-791038_1280.jpg'),
          ),
          decoration: PageDecoration(
            fullScreen: true,
            safeArea: 60,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        PageViewModel(
          title: 'This is Page 2',
          useScrollView: true,
          // titleWidget: Icon(Icons.phone),
          body: 'This is an example of onboarding screen',

          image: Center(
            child: Image.asset(
              'lib/opollophotography-property-7046997_1280.jpg',
            ),
          ),
          decoration: PageDecoration(
            fullScreen: true,
            safeArea: 60,
            titleTextStyle: TextStyle(fontSize: 30, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
