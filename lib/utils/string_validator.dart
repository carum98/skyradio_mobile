extension StringValidator on String? {
  bool validate({
    bool isRequired = false,
    int? min,
    int? max,
    int? length,
  }) {
    if (this == null || this!.isEmpty) {
      return !isRequired;
    }

    if (min != null && this!.length < min) {
      return false;
    }

    if (max != null && this!.length > max) {
      return false;
    }

    if (length != null && this!.length != length) {
      return false;
    }

    return true;
  }
}
