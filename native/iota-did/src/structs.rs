use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
pub struct Identity {
  pub key: Key,
  pub doc: Doc,
  pub message_id: String,
}

#[derive(Serialize, Deserialize)]
pub struct Key {
  pub r#type: String,
  pub public: String,
  pub secret: String,
}

#[derive(Serialize, Deserialize)]
pub struct Doc {
  pub id: String,
  pub authentication: Vec<Authentication>,
  pub created: String,
  pub updated: String,
  pub proof: Proof,
}

#[derive(Serialize, Deserialize)]
pub struct Proof {
  pub r#type: String,
  pub verification_method: String,
  pub signature_value :String
}

#[derive(Serialize, Deserialize)]
pub struct Authentication {
  pub id: String,
  pub controller: String,
  pub r#type: String,
  pub public_key_base58: String,
}