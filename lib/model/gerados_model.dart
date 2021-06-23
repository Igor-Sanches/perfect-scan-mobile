class Gerados{
  int? id, data;
  String? icone, displayName, result, formato, tipo, UUID;
  bool? isNuvem, isCamera;

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id': id,
      'displayName': displayName,
      'result': result,
      'data': data,
      'formato': formato,
      'tipo': tipo,
      'UUID': UUID,
      'isNuvem': isNuvem! ? 'true' : 'false',
      'isCamera': isNuvem! ? 'true' : 'false'
    };
  }

  Gerados.fromMap(Map<dynamic, dynamic> map){
    Gerados(
        id: map['id'],
        displayName: map['displayName'],
        result: map['result'],
        data: map['data'],
        formato: map['formato'],
        tipo: map['tipo'],
        UUID: map['UUID'],
        isNuvem: map['isNuvem'] == 'true',
        isCamera: map['isCamera'] == 'true'
    );

  }

  Gerados({
    this.id,
    required this.displayName,
    required this.result,
    required this.data,
    required this.formato,
    required this.tipo,
    this.UUID = '',
    required this.isNuvem,
    required this.isCamera
  });
}