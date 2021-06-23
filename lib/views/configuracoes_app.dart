
import 'package:flutter/material.dart';
import 'package:perfectscan/helper/colors.dart';
import 'package:perfectscan/helper/size_config.dart';
import 'package:perfectscan/viewModel/config_view_model.dart';
import 'package:stacked/stacked.dart';

class ConfigApplication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConfigApplication();
}

class _ConfigApplication extends State<ConfigApplication> {
  bool isWifiAllConnect = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ConfigViewModel>.reactive(
      viewModelBuilder: () => ConfigViewModel(),
      onModelReady: (viewModel) async => await viewModel.initialise(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colores.background,
        appBar: AppBar(title: const Text('Configurações')),
        body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('WI-FI + Links',
                    style: TextStyle(
                        color: Colores.accentColor,
                        fontSize: 17
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        viewModel.isUpdate ? Switch(
                          value: viewModel.isWifiAutoConnect,
                          onChanged: (value) {
                            setState(() {
                              viewModel.setWifiAutoConnect(value);
                            });
                          },
                          activeTrackColor: Colores.accentColorDark,
                          activeColor: Colores.accentColor,
                        ) : Container(child: CircularProgressIndicator(color: Colores.accentColor,), margin: const EdgeInsets.all(10),),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget> [
                                const Text('Conectar automaticamente nas rede WI-FI',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70
                                    )),
                                Text('Ao escanear um código que contém uma rede WI-FI será feita uma conexão automatica na rede.',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colores.texto
                                    )
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth - 20,
                    height: 0.5,
                    child: Container(color: Colors.blue),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        viewModel.isUpdate ? Switch(
                          value: viewModel.isAutoOpenLinks,
                          onChanged: (value) {
                            setState(() {
                              viewModel.setAutoOpenLinks(value);
                            });
                          },
                          activeTrackColor: Colores.accentColorDark,
                          activeColor: Colores.accentColor,
                        ) : Container(child: CircularProgressIndicator(color: Colores.accentColor,), margin: const EdgeInsets.all(10),),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget> [
                                const Text('Abrir links no navegador automaticamente',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70
                                    )),
                                Text('Quando um link for escaneado será redirecionado ao navegador',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colores.texto
                                    )
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  Text('Escanear',
                    style: TextStyle(
                        color: Colores.accentColor,
                        fontSize: 17
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  //   child: Row(
                  //     children: [
                  //       viewModel.isUpdate ? Switch(
                  //         value: viewModel.isAutoFocus,
                  //         onChanged: (value) {
                  //           setState(() {
                  //             viewModel.setAutoFocus(value);
                  //           });
                  //         },
                  //         activeTrackColor: Colores.accentColorDark,
                  //         activeColor: Colores.accentColor,
                  //       ) : Container(child: CircularProgressIndicator(color: Colores.accentColor,), margin: const EdgeInsets.all(10),),
                  //       const Expanded(
                  //           child: Text('Foco automatico',
                  //               softWrap: true,
                  //               style: TextStyle(
                  //                   fontSize: 16,
                  //                   color: Colors.white70
                  //               ))
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: SizeConfig.screenWidth - 20,
                  //   height: 0.5,
                  //   child: Container(color: Colors.blue),
                  // ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        viewModel.isUpdate ? Switch(
                          value: viewModel.isModoMassaPhoto,
                          onChanged: (value) {
                            setState(() {
                              viewModel.setModoMassaPhoto(value);
                            });
                          },
                          activeTrackColor: Colores.accentColorDark,
                          activeColor: Colores.accentColor,
                        ) : Container(child: CircularProgressIndicator(color: Colores.accentColor,), margin: const EdgeInsets.all(10),),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget> [
                                const Text('Modo em Massa em Imagens',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70
                                    )),
                                Text('Permite escanear sem para. Todos os resultados são salvos nos históricos sem pause. (Sem repetir os mesmos)',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colores.texto
                                    )
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth - 20,
                    height: 0.5,
                    child: Container(color: Colors.blue),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        viewModel.isUpdate ? Switch(
                          value: viewModel.isModoMassa,
                          onChanged: (value) {
                            setState(() {
                              viewModel.setModoMassa(value);
                            });
                          },
                          activeTrackColor: Colores.accentColorDark,
                          activeColor: Colores.accentColor,
                        ) : Container(child: CircularProgressIndicator(color: Colores.accentColor,), margin: const EdgeInsets.all(10),),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget> [
                                const Text('Modo em Massa',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70
                                    )),
                                Text('Permite escanear sem para. Todos os resultados são salvos nos históricos sem pause. (Sem repetir os mesmos)',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colores.texto
                                    )
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth - 20,
                    height: 0.5,
                    child: Container(color: Colors.blue),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        viewModel.isUpdate ? Switch(
                          value: viewModel.isApitar,
                          onChanged: (value) {
                            setState(() {
                              viewModel.setApitar(value);
                            });
                          },
                          activeTrackColor: Colores.accentColorDark,
                          activeColor: Colores.accentColor,
                        ) : Container(child: CircularProgressIndicator(color: Colores.accentColor,), margin: const EdgeInsets.all(10),),
                        const Expanded(
                            child: Text('Apitar',
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70
                                ))
                        )
                      ],
                    ),
                  ),
                  Text('Históricos',
                    style: TextStyle(
                        color: Colores.accentColor,
                        fontSize: 17
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        viewModel.isUpdate ? Switch(
                          value: viewModel.isSaveScanCodes,
                          onChanged: (value) {
                            setState(() {
                              viewModel.setSaveScanCodes(value);
                            });
                          },
                          activeTrackColor: Colores.accentColorDark,
                          activeColor: Colores.accentColor,
                        ) : Container(child: CircularProgressIndicator(color: Colores.accentColor,), margin: const EdgeInsets.all(10),),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget> [
                                const Text('Salvar códigos escaneados',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70
                                    )),
                                Text('Todos os códigos escaneados através da câmera ou imagens da galeria serão salvos nos históricos',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colores.texto
                                    )
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth - 20,
                    height: 0.5,
                    child: Container(color: Colors.blue),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        viewModel.isUpdate ? Switch(
                          value: viewModel.isSaveMakerCodes,
                          onChanged: (value) {
                            setState(() {
                              viewModel.setSaveMakerCodes(value);
                            });
                          },
                          activeTrackColor: Colores.accentColorDark,
                          activeColor: Colores.accentColor,
                        ) : Container(child: CircularProgressIndicator(color: Colores.accentColor,), margin: const EdgeInsets.all(10),),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget> [
                                const Text('Salvar códigos gerados',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70
                                    )),
                                Text('Todos os códigos gerados no app serão salvos nos históricos',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colores.texto
                                    )
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      )
    );
  }
}
