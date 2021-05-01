import "../../models/did.dart";

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {
  SubmissionSuccess(this.did, this.successMessage);

  final Did did;
  final String successMessage;
}

class SubmissionFailed extends FormSubmissionStatus {
  SubmissionFailed(this.error);

  final dynamic error;
}
