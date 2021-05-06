import "../../models/did/did.dart";

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {
  SubmissionSuccess(this.did);

  final Did did;
}

class SubmissionFailed extends FormSubmissionStatus {
  SubmissionFailed(this.error);

  final dynamic error;
}
