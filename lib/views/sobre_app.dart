
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:perfectscan/helper/colors.dart';
import 'package:perfectscan/helper/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class SobreApplication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SobreApplication();
}

class _SobreApplication extends State<SobreApplication> {
  String appName = 'Carregando...';
  String version = 'Carregando...';

  @override
  void initState() {
    PackageInfo.fromPlatform().then((packageInfo) {
      appName = packageInfo.appName;
      version = packageInfo.version;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colores.background,
        appBar: AppBar(
          title: const Text('Sobre'),
        ),
        body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colores.paneBackground,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Row(
                    children: <Widget> [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Image.asset('assets/app.png', width: 42, height: 42, color: Colores.icone,),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          Text(appName,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70
                              )),
                          Text('Igor Dutra Sanches',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colores.texto
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth - 20,
                    height: 0.5,
                    child: Container(color: Colores.texto),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text('Versão: $version',
                        style: TextStyle(
                            color: Colores.texto
                        )
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 5.3, 0),
                              child: TextButton(
                                  child: const Icon(Icons.payment),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                        EdgeInsets>(const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10)),
                                    foregroundColor: MaterialStateProperty
                                        .all<Color>(Colores.icone),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius
                                                .circular(24),
                                            side: BorderSide(
                                                color: Colores.texto,
                                                width: 0.1)
                                        )
                                    ),
                                    backgroundColor: MaterialStateProperty.all<
                                        Color>(Colores.paneBackground),
                                  ),
                                  onPressed: () => _actionAPI(url: '')
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(5.3, 0, 5.3, 0),
                              child: TextButton(
                                  child: const Icon(Icons.star),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                        EdgeInsets>(const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10)),
                                    foregroundColor: MaterialStateProperty
                                        .all<Color>(Colores.icone),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius
                                                .circular(24),
                                            side: BorderSide(
                                                color: Colores.texto,
                                                width: 0.1)
                                        )
                                    ),
                                    backgroundColor: MaterialStateProperty.all<
                                        Color>(Colores.paneBackground),
                                  ),
                                  onPressed: () => _actionAPI(url: '')
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(5.3, 0, 5.3, 0),
                              child: TextButton(
                                  child: const Icon(Icons.contact_support_outlined),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                        EdgeInsets>(const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10)),
                                    foregroundColor: MaterialStateProperty
                                        .all<Color>(Colores.icone),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius
                                                .circular(24),
                                            side: BorderSide(
                                                color: Colores.texto,
                                                width: 0.1)
                                        )
                                    ),
                                    backgroundColor: MaterialStateProperty.all<
                                        Color>(Colores.paneBackground),
                                  ),
                                  onPressed: () => _actionAPI(url: '')
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(5.3, 0, 0, 0),
                              child: TextButton(
                                  child: const Icon(Icons.backup),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                        EdgeInsets>(const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10)),
                                    foregroundColor: MaterialStateProperty
                                        .all<Color>(Colores.icone),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius
                                                .circular(24),
                                            side: BorderSide(
                                                color: Colores.texto,
                                                width: 0.1)
                                        )
                                    ),
                                    backgroundColor: MaterialStateProperty.all<
                                        Color>(Colores.paneBackground),
                                  ),
                                  onPressed: () {
                                  }
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Contatos/Redes sociais',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70
                            )
                        ),
                        SizedBox(
                          child: TextButton(onPressed: () => _actionAPI(url: 'https://api.whatsapp.com/send?phone=5598985766514&text=Olá!'),
                              child: Text('WhatsApp',
                                  style: TextStyle(
                                      color: Colores.accentColor
                                  ))),
                          height: 32,
                        ),
                        SizedBox(
                          child: TextButton(onPressed: () => _actionAPI(url: 'tel://5598985766514'),
                              child: Text('Telefone',
                                  style: TextStyle(
                                      color: Colores.accentColor
                                  ))),
                          height: 32,
                        ),
                        SizedBox(
                          child: TextButton(onPressed: () => _actionEmail(),
                              child: Text('E-Mail',
                                  style: TextStyle(
                                      color: Colores.accentColor
                                  ))),
                          height: 32,
                        ),
                        SizedBox(
                          child: TextButton(onPressed: () => _actionAPI(url: 'http://www.facebook.com/igor.dutra.3557'),
                              child: Text('Facebook',
                                  style: TextStyle(
                                      color: Colores.accentColor
                                  ))),
                          height: 32,
                        ),
                        SizedBox(
                          child: TextButton(onPressed: () => _actionAPI(url: 'http://www.instagram.com/igor_sanches'),
                              child: Text('Instagram',
                                  style: TextStyle(
                                      color: Colores.accentColor
                                  ))),
                          height: 32,
                        ),
                        SizedBox(
                          child: TextButton(onPressed: () => _actionAPI(url: 'http://www.twitter.com/igordutra2014'),
                              child: Text('Twitter',
                                  style: TextStyle(
                                      color: Colores.accentColor
                                  ))),
                          height: 32,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextButton(onPressed: () => _actionAPI(url: ''),
                              child: Text('Politica de Privacidade e Termos de Uso',
                                  style: TextStyle(
                                      color: Colores.accentColor
                                  ))),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10),
                    color: Colores.background,
                    child: Text('Igor Dutra Sanches designer e fundador do Perfect Scan. Qualquer duvida e ideias para melhorar o app, por favor entre em contato.',
                      style: TextStyle(
                          color: Colores.texto,
                        fontSize: 17
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    width: SizeConfig.screenWidth,
                    child: Text('Perfect Scan @ 2017-2021',
                      style: TextStyle(
                          color: Colores.texto,
                          fontSize: 15
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )
        )
    );
  }

  _actionAPI({String? url}) async {
    if (await canLaunch(url!)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        );
      }
    }
  }

  _actionEmail() async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'igordutra2014@live.com',
        queryParameters: {
          'subject': 'Olá!'
        }
    );
    launch(_emailLaunchUri.toString());
  }
}
