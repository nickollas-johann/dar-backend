abstract class ServiceInterface<T> {

  Future<T?> findOne(int id);
  Future< List<T>> findAll(int id);
  Future<bool> save(T value);
  Future<bool> delete(int value);

}