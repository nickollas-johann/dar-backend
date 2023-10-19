abstract class DAO<T> {
  Future<bool> create(T value);
  Future<T?> getOne(int id);
  Future<List<T>> getAll(); 
  Future<bool> update(T value);
  Future<bool> delete(int id);

}