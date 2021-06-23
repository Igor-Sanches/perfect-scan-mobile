
import 'dart:io';

import 'package:fialogs/fialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectscan/helper/colors.dart';
import 'package:perfectscan/helper/escaneados_database.dart';
import 'package:perfectscan/helper/tools.dart';
import 'package:perfectscan/helper/verificador_code.dart';
import 'package:perfectscan/model/escaneados_model.dart';
import 'package:perfectscan/settings/settings.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class EscanearView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EscanearView();
}

class _EscanearView extends State<EscanearView> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isFlash = false, isFlontal = false, isPaused = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: _buildQrView(context),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              verticalDirection: VerticalDirection.up,
              children: [
                Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() { isFlash = !isFlash;});
                      },
                      mini: true,
                      child: isFlash ? const Icon(Icons.flash_off) : const Icon(Icons.flash_on, color: Colors.white70),
                      backgroundColor: Colores.accentColor,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: FloatingActionButton(
                        onPressed: () async {
                          await controller!.flipCamera();
                          setState(() {isFlontal = !isFlontal;});
                        },
                        mini: true,
                        child: isFlontal ? const Icon(Icons.camera_alt) : const Icon(Icons.camera_front, color: Colors.white70),
                        backgroundColor: Colores.accentColor,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextButton(
                          child: Text(
                              isPaused ? "Continuar" : "Pausar",
                              style: const TextStyle(fontSize: 13)
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(12, 10, 12, 10)),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(color: Colores.accentColor, width: 1.5)
                                  )
                              )
                          ),
                          onPressed: () async {
                            if(isPaused){
                              await controller?.resumeCamera();
                              isPaused = !isPaused;
                            }else{
                              await controller?.pauseCamera();
                              isPaused = !isPaused;
                            }
                            escaneado = false;
                            setState(() {

                            });
                          }
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 270.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }

  bool escaneado = false;

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((_result) async {
      if (!escaneado){
        escaneado = true;
        bool? modoMassa = await Settings.isWifiAutoConnect;
        progressDialog(
          context,
          backgroundColor: Colores.paneBackground,
          titleWidget: Text("Escaneando...", style: dialogTitleStyle(context),),
          progressDialogType: ProgressDialogType.CIRCULAR,
          hideNeutralButton: true,
          closeOnBackPress: false,
        );

        var db = EscaneadosDatabase();
        String? _name = Tools.getType(cameraEscaneamento: _result.format);
        String? _formato = Tools.getFormato(cameraEscaneamento: _result.format);
        var _escaneado = Escaneados(
            displayName: _name,
            result: _result.code,
            data: DateTime
                .now()
                .millisecondsSinceEpoch,
            formato: _formato,
            tipo: FindCode.GetResultado(codigo: _result.code, format: _formato!),
            isNuvem: false,
            isCamera: false);
        var id = db.adicionar(_escaneado);
        Navigator.of(context).pop(false);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}