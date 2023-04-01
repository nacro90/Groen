
class DeserializeException extends FormatException {
  const DeserializeException(String message)
      : super("Error while deserializing input: $message");
}
