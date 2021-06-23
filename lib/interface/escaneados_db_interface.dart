import 'package:perfectscan/model/escaneados_model.dart';

abstract class IEscaneados{
  Future<int?> delete(int id);
  Future<int?> atualizar(Map<String, Object?> escaneado, int id);
  Future<int?> numerosEscaneados();
  Future<int?> adicionar(Escaneados escaneado);
  Future<Escaneados?> getEscaneado(int? id);
  Future<List<Map>?> lista();
  Future<bool?> isNotEmpty(String codigo, String formato);
  Future close();
}