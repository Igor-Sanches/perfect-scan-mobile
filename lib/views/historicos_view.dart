
import 'dart:collection';

import 'package:fialogs/fialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectscan/helper/colors.dart';
import 'package:perfectscan/helper/escaneados_database.dart';
import 'package:perfectscan/helper/gerados_database.dart';
import 'package:perfectscan/helper/size_config.dart';
import 'package:perfectscan/helper/verificador_code.dart';
import 'package:perfectscan/widget/my_snackbar.dart';

class HistoricosView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HistoricosView();
}

class _HistoricosView extends State<HistoricosView>  with SingleTickerProviderStateMixin{

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Escaneados'),
    Tab(text: 'Gerados'),
  ];

  List<Map<dynamic, dynamic>>? _escaneadosList;
  List<Map<dynamic, dynamic>>? _geradosList;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    iniciarEscaneados();
    iniciarGerados();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colores.background,
      appBar: AppBar(
        title: const Text('Históricos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          if(tab.text == 'Escaneados'){
            return _escaneados(context);
          }else{
            return _gerados(context);
          }
        }).toList(),
      ),
    );
  }

  Widget _gerados(BuildContext context) {
    if(_geradosList != null){
      if(_geradosList!.isNotEmpty) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: _geradosList!.length,
            itemBuilder: (context, index) {
              var item = _geradosList![index];
              String codigoCompleto = item['result'];
              String codigo = codigoCompleto.substring(
                  0, codigoCompleto.length >= 50 ? 50 : codigoCompleto.length);
              String resumo = '${Verificador.getTipo(item['tipo'])} ~ $codigo';
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: InkWell(
                    onLongPress: () async{
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colores.paneBackground,
                          title: Text('Oque deseja?',
                              style: TextStyle(
                                  color: Colores.texto,
                                  fontSize: 18
                              )),
                          content: SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                            Text('Renomear',
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
                                    onPressed: (){
                                      Navigator.of(context).pop(false);
                                      _renomear(item['displayName'], item['id'], false);
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
                                              child: Icon(Icons.delete,
                                                size: 22,
                                                color: Colores.icone,
                                              ),
                                            ),
                                            Text('Apagar',
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
                                    onPressed: (){
                                      Navigator.of(context).pop(false);
                                      _deletar(item['displayName'], item['id'], false);
                                    }
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Fechar',
                                  style: TextStyle(
                                      color: Colores.accentColor
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                    onTap: () => null,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 12, 0, 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: item['id'],
                            child: Image(
                              image: AssetImage(
                                  Verificador.getIcone(item['tipo'])),
                              fit: BoxFit.cover,
                              color: Colores.icone,
                              width: 32.0,
                              height: 32.0,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['displayName'],
                                  softWrap: false,
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17.0,
                                      color: Colores.texto,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(resumo,
                                  style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 13.0,
                                      color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10,)
                        ],
                      ),
                    )
                ),
              );
            }
        );
      }else{
        return const DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/list_clear.png'),
                    fit: BoxFit.fill
                ))
        );
      }
    }else{
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _escaneados(BuildContext context) {
    if(_escaneadosList != null){
      if(_escaneadosList!.isNotEmpty) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: _escaneadosList!.length,
            itemBuilder: (context, index) {
              var item = _escaneadosList![index];
              String codigoCompleto = item['result'];
              String codigo = codigoCompleto.substring(
                  0, codigoCompleto.length >= 50 ? 50 : codigoCompleto.length);
              String resumo = '${Verificador.getTipo(item['tipo'])} ~ $codigo';
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: InkWell(
                  onLongPress: () async{
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colores.paneBackground,
                        title: Text('Oque deseja?',
                            style: TextStyle(
                                color: Colores.texto,
                                fontSize: 18
                            )),
                        content: SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                          Text('Renomear',
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
                                  onPressed: (){
                                    Navigator.of(context).pop(false);
                                    _renomear(item['displayName'], item['id'], true);
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
                                            child: Icon(Icons.delete,
                                              size: 22,
                                              color: Colores.icone,
                                            ),
                                          ),
                                          Text('Apagar',
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
                                  onPressed: (){
                                    Navigator.of(context).pop(false);
                                    _deletar(item['displayName'], item['id'], true);
                                  }
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('Fechar',
                                style: TextStyle(
                                    color: Colores.accentColor
                                )),
                          ),
                        ],
                      ),
                    );
                  },
                    onTap: () => null,
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 12, 0, 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: item['id'],
                              child: Image(
                                image: AssetImage(
                                    Verificador.getIcone(item['tipo'])),
                                fit: BoxFit.cover,
                                color: Colores.icone,
                                width: 32.0,
                                height: 32.0,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['displayName'],
                                    softWrap: false,
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 17.0,
                                        color: Colores.texto,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(resumo,
                                    style: const TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 13.0,
                                        color: Colors.grey
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10,)
                          ],
                        ),
                    )
                ),
              );
            }
        );
      }else{
        return const DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/list_clear.png'),
                    fit: BoxFit.fill
                ))
        );
      }
    }else{
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  void iniciarEscaneados() async {
    var db = EscaneadosDatabase();
    _escaneadosList = await db.lista();
    setState(() {

    });
  }

  void iniciarGerados() async {
    var db = GeradosDatabase();
    _geradosList = await db.lista();
    setState(() {

    });
  }

  void _deletar(String displayName, int id, bool escaneado)async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colores.paneBackground,
        title: Text(displayName,
            style: TextStyle(
                color: Colores.texto,
                fontSize: 18
            )),
        content: const Text('Deseja apagar este histórico?',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 16
            )),
        actions: <Widget>[
          TextButton(
            onPressed: ()async{
              if(escaneado){
                var db =  EscaneadosDatabase();
                var result = await db.delete(id);
                if(result == 1){
                  iniciarEscaneados();
                }
                Navigator.of(context).pop(false);
              }else{
                var db =  GeradosDatabase();
                var result = await db.delete(id);
                if(result == 1){
                  iniciarGerados();
                }
                Navigator.of(context).pop(false);
              }

            },
            child: Text('Apagar',
                style: TextStyle(
                    color: Colores.accentColor
                )),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('cancelar',
                style: TextStyle(
                    color: Colores.accentColor
                )),
          ),
        ],
      ),
    );
  }

  final TextEditingController _displayNameEditor = TextEditingController();
  void _renomear(String displayName, int id, bool escaneado) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
      backgroundColor: Colores.paneBackground,
      title: Text('Renomear',
          style: TextStyle(
              color: Colores.texto,
              fontSize: 18
          )),
      content: CupertinoTextField(
        controller: _displayNameEditor,
        decoration: BoxDecoration(
          color: Colores.background,
          borderRadius: BorderRadius.circular(20),

        ),
        textInputAction: TextInputAction.next,
        restorationId: 'pin_text_field',
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        clearButtonMode: OverlayVisibilityMode.editing,
        keyboardType: TextInputType.emailAddress,
        placeholder: displayName,
        placeholderStyle: TextStyle(color: Colores.texto),
        style: const TextStyle(color: Colors.white),

      ),
      actions: <Widget>[
        TextButton(
          onPressed: ()async{
            if(escaneado){
              var nome = _displayNameEditor.text;
              if(nome.isNotEmpty) {
                RegExp nomeRegex = RegExp("[a-zA-ZÇçãõíóáéâ ÃÂÁÉÍÓÚú]+");
                if(nomeRegex.stringMatch(nome) == null){
                  MySnackbar.myMensage(context, 'Digite um nome valido');
                  return;
                }
                if(nomeRegex.stringMatch(nome)!.length != nome.length){
                  MySnackbar.myMensage(context, 'Digite um nome valido');
                  return;
                }
                var db = EscaneadosDatabase();
                Map<String, Object?> value = HashMap();
                value['displayName'] = nome;
                var result = await db.atualizar(value, id);
                if (result == 1) {
                  iniciarEscaneados();
                  _displayNameEditor.text = '';
                }
                Navigator.of(context).pop(false);
              }else{
                MySnackbar.myMensage(context, 'Digite antes de tentar salvar');
              }
            }else{
              var nome = _displayNameEditor.text;
              if(nome.isNotEmpty) {
                RegExp nomeRegex = RegExp("[a-zA-ZÇçãõí1234567890óáéâ ÃÂÁÉÍÓÚú]+");
                if(nomeRegex.stringMatch(nome) == null){
                  MySnackbar.myMensage(context, 'Digite um nome valido');
                  return;
                }
                if(nomeRegex.stringMatch(nome)!.length != nome.length){
                  MySnackbar.myMensage(context, 'Digite um nome valido');
                  return;
                }
                var db = GeradosDatabase();
                Map<String, Object?> value = HashMap();
                value['displayName'] = nome;
                var result = await db.atualizar(value, id);
                if (result == 1) {
                  iniciarGerados();
                  _displayNameEditor.text = '';
                }
                Navigator.of(context).pop(false);
              }else{
                MySnackbar.myMensage(context, 'Digite antes de tentar salvar');
              }
            }

          },
          child: Text('Renomear',
              style: TextStyle(
                  color: Colores.accentColor
              )),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('cancelar',
              style: TextStyle(
                  color: Colores.accentColor
              )),
        ),
      ],
    ),
    );
  }
}
