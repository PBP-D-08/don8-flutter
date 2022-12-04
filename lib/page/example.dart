import 'package:don8_flutter/common/constants.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class ContohPenggunaan extends StatelessWidget {
  const ContohPenggunaan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Design System"),
      ),
      drawer: const DrawerApp(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //
            children: [
              // Contoh make yg dari class TextTheme (ribet kalo mau override stylenya)
              Text(
                "ini headline 2 TextTheme",
                style: myTextTheme.headline2,
              ),
              Text(
                "ini headline 3 TextTheme",
                style: myTextTheme.headline3,
              ),
              Text(
                "ini headline 4 TextTheme",
                style: myTextTheme.headline4,
              ),
      
              // Ini kalo misalkan mau override style pake class TextStyle
              Text(
                "ini heading 2 ganti warna",
                style: heading2.copyWith(color: orangeMedium),
              ),
      
              Text(
                "ini default text style nya, kalo mau override pake ini aja",
                style: defaultText.copyWith(
                    color: orangeDark, fontWeight: FontWeight.w600),
              ),
              ElevatedButton(onPressed: (() => {}), child: const Text("tes button")),
              TextButton(
                  onPressed: (() => {}), child: const Text("ini textButton"))
            ],
          ),
        ),
      ),
    );
  }
}
