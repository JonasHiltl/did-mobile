import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:sqflite_sqlcipher/sql.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();

  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async => _database ??= await _initDatabase();

  // TODO: implement https call to get password from server

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "documents.db");

    return await openDatabase(
      path,
      password: "TestPassword",
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE patient_questionnaires(
      context TEXT NOT NULL,
      id TEXT NOT NULL,
      type TEXT NOT NULL,
      document_name TEXT NOT NULL,
      first_name TEXT NOT NULL,
      last_name TEXT NOT NULL,
      email TEXT NOT NULL,
      phone_number TEXT NOT NULL,
      birth TEXT NOT NULL,
      sex TEXT NOT NULL,
      street TEXT NOT NULL,
      city TEXT NOT NULL,
      state TEXT NOT NULL,
      postal_code TEXT NOT NULL,
      country TEXT NOT NULL,
      allergies TEXT NOT NULL,
      medication TEXT NOT NULL,
      issuer TEXT NOT NULL,
      issuance_date TEXT NOT NULL,
      proof_type TEXT NOT NULL,
      proof_verification_method TEXT NOT NULL,
      proof_signature_value TEXT NOT NULL
    )
    ''');
  }

  Future<List<PatientQuestionnaireVc>> getPatientQuestionnaires() async {
    final Database db = await instance.database;
    final patientQuestionnaires = await db.query("patient_questionnaires");

    final List<PatientQuestionnaireVc> patientQuestionnaireslist =
        patientQuestionnaires.isNotEmpty
            ? patientQuestionnaires
                .map((e) => PatientQuestionnaireVc.fromDB(e))
                .toList()
            : [];
    return patientQuestionnaireslist;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
