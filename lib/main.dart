import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfectscan/views/configuracoes_app.dart';
import 'package:perfectscan/views/escanear.dart';
import 'package:perfectscan/views/escanear_imagem.dart';
import 'package:perfectscan/views/historicos_view.dart';
import 'package:perfectscan/views/sobre_app.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:perfectscan/responsive.dart';
import 'package:perfectscan/controller.dart';

import 'helper/colors.dart';
import 'helper/size_config.dart';
import 'navegador/navegador.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colores.background,
    statusBarColor: Colores.background,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colores.toollbar,
          backgroundColor: Colores.background,
          accentColor: Colores.accentColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Georgia',
          textTheme: GoogleFonts.poppinsTextTheme().copyWith(
            caption: const TextStyle(
                color: Colors.white,
                fontSize: 18.0
            ),
            headline1: const TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: const TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: const TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          )
      ),
      color: Colores.paneBackground,
      title: 'BirdSoft Technologies',
      home: const MyHomePage(),
      // home: MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(
      //       create: (context) => MenuController(),
      //     )
      //   ],
      //   child: const MyHomePage(),
      // ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Constants{
  static const String papel_parede = 'Papel de parede';
  static const List<String> choices = <String>[
    papel_parede
  ];
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colores.background,
      appBar: AppBar(
        title: const Text("Inicio"),
        backgroundColor: Colores.toollbar,
        // actions: [
        //   PopupMenuButton<String>(
        //     icon: Icon(Icons.more_vert),
        //     color: Colores.paneBackground,
        //     onSelected: (item) => null,
        //     itemBuilder: (BuildContext context){
        //       return Constants.choices.map((String choice){
        //         return PopupMenuItem<String>(
        //             textStyle: TextStyle(
        //                 color: Colores.texto
        //             ),
        //             value: choice,
        //             child: Text(choice));
        //       })
        //           .toList();
        //     }
        //     ,),
        // ],
      ),
      body: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if(Responsive.isDesktop(context))
              //   Expanded(child: MenuHamburger()),

              Expanded(
                flex: 5,
                child: Stack(
                    children: [
                      Image.asset('assets/background.jpg'),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 100,
                                color: const Color.fromRGBO(165, 175, 182, 0.5),
                                width: SizeConfig.screenWidth / 2 - 1.5,
                                child: TextButton(
                                    child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                              child: const Icon(Icons.camera,
                                                size: 22,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const Text("Escanear",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight
                                                      .normal
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    onPressed: () => Navigation.push(EscanearView(), context)
                                ),
                              ),
                              Container(
                                height: 100,
                                color: const Color.fromRGBO(165, 175, 182, 0.5),
                                width: SizeConfig.screenWidth / 2 - 1.5,
                                child: TextButton(
                                    child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                              child: const Icon(Icons.picture_in_picture,
                                                size: 22,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const Text("Escanear Imagem",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight
                                                      .normal
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    onPressed: () => Navigation.push(EscanearImagem(), context)
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                height: 100,
                                color: const Color.fromRGBO(165, 175, 182, 0.5),
                                width: SizeConfig.screenWidth / 3 - 1.5,
                                child: TextButton(
                                    child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                              child: const Icon(Icons.history,
                                                size: 22,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const Text("Históricos",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight
                                                      .normal
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    onPressed: () => Navigation.push(HistoricosView(), context)
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                height: 100,
                                color: const Color.fromRGBO(165, 175, 182, 0.5),
                                width: SizeConfig.screenWidth / 3 - 1.5,
                                child: TextButton(
                                    child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                              child: const Icon(Icons.edit,
                                                size: 22,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const Text("Gerar Códigos",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight
                                                      .normal
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    onPressed: () => null
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                height: 100,
                                color: const Color.fromRGBO(165, 175, 182, 0.5),
                                width: SizeConfig.screenWidth / 3 - 1.5,
                                child: TextButton(
                                    child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                              child: const Icon(Icons.settings,
                                                size: 22,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const Text("Configurações",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight
                                                      .normal
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    onPressed: () => null
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                height: 100,
                                color: const Color.fromRGBO(165, 175, 182, 0.5),
                                width: SizeConfig.screenWidth / 2 - 1.5,
                                child: TextButton(
                                    child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                              child: const Icon(Icons.cloud,
                                                size: 22,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const Text("Nuvem",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight
                                                      .normal
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    onPressed: () => null
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                height: 100,
                                color: const Color.fromRGBO(165, 175, 182, 0.5),
                                width: SizeConfig.screenWidth / 2 - 1.5,
                                child: TextButton(
                                    child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                              child: const Icon(Icons.backup,
                                                size: 22,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const Text("Backup Local",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight
                                                      .normal
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    onPressed: () => null
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                height: 100,
                                color: const Color.fromRGBO(165, 175, 182, 0.5),
                                width: SizeConfig.screenWidth / 3 - 1.5,
                                child: TextButton(
                                    child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                              child: const Icon(Icons.star,
                                                size: 22,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const Text("Avliar App",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight
                                                      .normal
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    onPressed: () => null
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                height: 100,
                                color: const Color.fromRGBO(165, 175, 182, 0.5),
                                width: SizeConfig.screenWidth / 1.5 - 1.5,
                                child: TextButton(
                                    child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                              child: const Icon(Icons.contact_support_outlined,
                                                size: 22,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const Text("Contato",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight
                                                      .normal
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    onPressed: () => null
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                height: 100,
                                color: const Color.fromRGBO(165, 175, 182, 0.7),
                                width: SizeConfig.screenWidth - 1.5,
                                child: TextButton(
                                    child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                              child: const Icon(Icons.desktop_windows,
                                                size: 22,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const Text("versão Desktop",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight
                                                      .normal
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    onPressed: () => null
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ]
                ),
              )
            ],
          )
      ),
      drawer: const MenuHamburger(),
    );
  }
}

class MenuHamburger extends StatelessWidget{
  const MenuHamburger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          color: Colores.paneBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 28),
                      // Container(
                      //   margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      //   child: IconButton(
                      //     onPressed: () => null,
                      //     icon: Icon(Icons.arrow_back),
                      //     iconSize: 22,
                      //     color: Colores.icone,
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: IconButton(
                          onPressed: () => null,
                          icon: Icon(Icons.menu),
                          iconSize: 22,
                          color: Colores.icone,
                        ),
                      ),
                      TextButton(
                          child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(Icons.home,
                                      size: 22,
                                      color: Colores.icone,
                                    ),
                                  ),
                                  Text("Inicio",
                                    style: TextStyle(
                                        color: Colores.texto,
                                        fontSize: 12,
                                        fontWeight: FontWeight
                                            .normal
                                    ),
                                  )
                                ],
                              )
                          ),
                          onPressed: () => null
                      ),
                      TextButton(
                          child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(Icons.camera,
                                      size: 22,
                                      color: Colores.icone,
                                    ),
                                  ),
                                  Text("Escanear",
                                    style: TextStyle(
                                        color: Colores.texto,
                                        fontSize: 12,
                                        fontWeight: FontWeight
                                            .normal
                                    ),
                                  )
                                ],
                              )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            Navigation.push(ConfigApplication(), context);
                          }
                      ),
                      TextButton(
                          child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(Icons.picture_in_picture,
                                      size: 22,
                                      color: Colores.icone,
                                    ),
                                  ),
                                  Text("Escanear Imagem",
                                    style: TextStyle(
                                        color: Colores.texto,
                                        fontSize: 12,
                                        fontWeight: FontWeight
                                            .normal
                                    ),
                                  )
                                ],
                              )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            Navigation.push(EscanearImagem(), context);
                          }
                      ),
                      TextButton(
                          child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(Icons.edit,
                                      size: 22,
                                      color: Colores.icone,
                                    ),
                                  ),
                                  Text("Gerar Códigos",
                                    style: TextStyle(
                                        color: Colores.texto,
                                        fontSize: 12,
                                        fontWeight: FontWeight
                                            .normal
                                    ),
                                  )
                                ],
                              )
                          ),
                          onPressed: () => null
                      ),
                      TextButton(
                          child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(Icons.history,
                                      size: 22,
                                      color: Colores.icone,
                                    ),
                                  ),
                                  Text("Históricos",
                                    style: TextStyle(
                                        color: Colores.texto,
                                        fontSize: 12,
                                        fontWeight: FontWeight
                                            .normal
                                    ),
                                  )
                                ],
                              )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            Navigation.push(HistoricosView(), context);
                          }
                      ),
                      TextButton(
                          child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(Icons.cloud,
                                      size: 22,
                                      color: Colores.icone,
                                    ),
                                  ),
                                  Text("Nuvem",
                                    style: TextStyle(
                                        color: Colores.texto,
                                        fontSize: 12,
                                        fontWeight: FontWeight
                                            .normal
                                    ),
                                  )
                                ],
                              )
                          ),
                          onPressed: () => null
                      ),
                      TextButton(
                          child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(Icons.backup,
                                      size: 22,
                                      color: Colores.icone,
                                    ),
                                  ),
                                  Text("Backup local",
                                    style: TextStyle(
                                        color: Colores.texto,
                                        fontSize: 12,
                                        fontWeight: FontWeight
                                            .normal
                                    ),
                                  )
                                ],
                              )
                          ),
                          onPressed: () => null
                      ),
                      TextButton(
                          child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: Icon(Icons.payment,
                                      size: 22,
                                      color: Colores.icone,
                                    ),
                                  ),
                                  Text("Comprar ou Doar",
                                    style: TextStyle(
                                        color: Colores.texto,
                                        fontSize: 12,
                                        fontWeight: FontWeight
                                            .normal
                                    ),
                                  )
                                ],
                              )
                          ),
                          onPressed: () => null
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  TextButton(
                      child: SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment
                                .center,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                child: Icon(Icons.info_outline,
                                  size: 22,
                                  color: Colores.icone,
                                ),
                              ),
                              Text("Sobre",
                                style: TextStyle(
                                    color: Colores.texto,
                                    fontSize: 12,
                                    fontWeight: FontWeight
                                        .normal
                                ),
                              )
                            ],
                          )
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        Navigation.push(SobreApplication(), context);
                      }
                  ),
                  TextButton(
                      child: SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment
                                .center,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                child: Icon(Icons.settings,
                                  size: 22,
                                  color: Colores.icone,
                                ),
                              ),
                              Text("Configurações",
                                style: TextStyle(
                                    color: Colores.texto,
                                    fontSize: 12,
                                    fontWeight: FontWeight
                                        .normal
                                ),
                              )
                            ],
                          )
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        Navigation.push(ConfigApplication(), context);
                      }
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
