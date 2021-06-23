abstract class RequestStatus {
  const RequestStatus();
}

class InitialRequestStatus extends RequestStatus {
  const InitialRequestStatus();
}

class Requesting extends RequestStatus {}

class RequestSuccess extends RequestStatus {}

class RequestFailed extends RequestStatus {
  RequestFailed(this.error);

  final String error;
}
