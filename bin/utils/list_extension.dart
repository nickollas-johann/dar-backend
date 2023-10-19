extension ListEntension<E> on List<E> {
  E? firstWhereOrnull(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
