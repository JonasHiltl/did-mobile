abstract class RetrieveStatus {
  const RetrieveStatus();
}

class InitialRetrieveStatus extends RetrieveStatus {
  const InitialRetrieveStatus();
}

class Initializing extends RetrieveStatus {}

class Retrieving extends RetrieveStatus {}

class RetrieveSuccess extends RetrieveStatus {}

class RetrieveFailed extends RetrieveStatus {
  RetrieveFailed(this.error);

  final String error;
}
