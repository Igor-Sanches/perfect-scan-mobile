import 'package:perfectscan/model/escaneados_model.dart';
import 'package:perfectscan/model/gerados_model.dart';

abstract class IGerados{
  Future<int?> delete(int id);
  Future<int?> atualizar(Map<String, Object?> gerados, int id);
  Future<int?> numerosGerados();
  Future<int?> adicionar(Gerados gerados);
  Future<Gerados?> getGerado(int? id);
  Future<List<Map>?> lista();
  Future<bool?> isNotEmpty(String codigo, String formato);
  Future close();
}