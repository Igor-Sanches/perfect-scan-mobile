
import 'dart:io';
import 'package:fialogs/fialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectscan/helper/colors.dart';
import 'dart:async';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfectscan/helper/decode.dart';
import 'package:perfectscan/helper/escaneados_database.dart';
import 'package:perfectscan/helper/tools.dart';
import 'package:perfectscan/helper/verificador_code.dart';
import 'package:perfectscan/model/escaneados_model.dart';
import 'package:perfectscan/widget/my_snackbar.dart';
import 'package:zxing2/qrcode.dart';

class EscanearImagem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EscanearImagem();
}

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);

final ImagePicker _picker = ImagePicker();
final TextEditingController maxWidthController = TextEditingController();
final TextEditingController maxHeightController = TextEditingController();
final TextEditingController qualityController = TextEditingController();
dynamic _pickImageError;
late AppState state;
File? imageFile;

enum AppState {
  free,
  picked,
  cropped,
}

class _EscanearImagem extends State<EscanearImagem> {

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores.background,
      appBar: AppBar(
        backgroundColor: Colores.paneBackground,
        title: const Text('Escanear Imagem'),
        actions: [
          IconButton(
              onPressed: (){
                if(state == AppState.picked || imageFile != null){
                  _cropImage();
                }else{
                  MySnackbar.myMensage(context, 'Selecione uma imagem antes de tentar cortar');
                }
              },
              icon: const Icon(Icons.crop)
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: imageFile != null ?
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.file(imageFile!),
                ) : Container(
                  margin: const EdgeInsets.fromLTRB(40, 40, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Icon(Icons.camera_alt, color: Colores.icone,),
                          ),
                          Text('Capture uma nova imagem', style: TextStyle(color: Colores.texto),)
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Icon(Icons.picture_in_picture, color: Colores.icone,),
                          ),
                          Text('Selecione uma imagem na galeria', style: TextStyle(color: Colores.texto),)
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Icon(Icons.crop, color: Colores.icone,),
                          ),
                          Text('Cortar a imagem', style: TextStyle(color: Colores.texto),)
                        ],
                      )
                    ],
                  ),
                )
            ),
          ),
          Container(
            color: Colores.paneBackground,
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => _cameraPhoto(),
                    icon: Icon(Icons.camera_alt, color: Colores.icone)
                ),
                IconButton(
                    onPressed: () => _pickImage(),
                    icon: Icon(Icons.picture_in_picture, color: Colores.icone)
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: TextButton(
                      onPressed: () => _iniciarEscaneamento(context),
                      child: Text('Iniciar escaneamento', style: TextStyle(color: Colores.texto))
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<Null> _pickImage() async {
    final pickedImage =
    await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: Platform.isAndroid
        ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
        ]
        : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cortar imagem',
            toolbarColor: Colores.toollbar,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Cortar imagem',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        //state = AppState.cropped;
      });
    }
  }

  _cameraPhoto() async {

    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.camera,
        maxWidth: null,
        maxHeight: null,
        imageQuality: null,
      );
      setState(() {
        imageFile = File(pickedFile!.path);
        state = AppState.picked;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }
}

void _iniciarEscaneamento(BuildContext context) async {
  if(imageFile != null) {
   progressDialog(
      context,
      backgroundColor: Colores.paneBackground,
      titleWidget: Text("Escaneando...", style: dialogTitleStyle(context),),
      progressDialogType: ProgressDialogType.CIRCULAR,
      hideNeutralButton: true,
      closeOnBackPress: false,
    );

    Result? _result = decode(imageFile!);
    if (_result != null) {
      var db = EscaneadosDatabase();
      String _name = Tools.getType(imagemEscaneamento: _result.format);
      String _formato = Tools.getFormato(imagemEscaneamento: _result.format);
      var _escaneado = Escaneados(
          displayName: _name,
          result: _result.text,
          data: DateTime
              .now()
              .millisecondsSinceEpoch,
          formato: _formato,
          tipo: FindCode.GetResultado(codigo: _result.text, format: _formato),
          isNuvem: false,
          isCamera: false);
      var id = db.adicionar(_escaneado);
      Navigator.of(context).pop(false);
    }else{
      Navigator.of(context).pop(false);
      MySnackbar.myMensage(context, 'Não foi possível escanear a imagem, veja se esta bem visível ou tente conta-la');
    }

  }else{
    MySnackbar.myMensage(context, 'Selecione uma imagem para escanear');
  }
}
