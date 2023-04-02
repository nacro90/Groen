class DeserializeException extends FormatException {
  const DeserializeException(String message)
      : super("Error while deserializing input: $message");
}

class SerializeException extends FormatException {
  const SerializeException(String message)
      : super("Error while serializing input: $message");
}
