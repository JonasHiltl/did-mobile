#![allow(dead_code)]
#![allow(unused_imports)]

use identity::core::json;
use identity::core::FromJson;
use identity::core::Url;
use identity::credential::Credential;
use identity::credential::CredentialBuilder;
use identity::credential::Subject;
use identity::crypto::KeyPair;
use identity::iota::Client;
use identity::iota::IotaDocument;
use identity::iota::Result;

pub fn add(a: i64, b: i64) -> i64 {
    a.wrapping_add(b)
}

pub async fn create_did_document() -> Result<(IotaDocument, KeyPair)> {
    // Generate a new DID Document and public/private key pair.
    // The generated document will have an authentication key associated with
    // the keypair.
    let client = &Client::new().await?;
    let keypair: KeyPair = KeyPair::new_ed25519()?;
    let mut document: IotaDocument = IotaDocument::from_keypair(&keypair)?;

    // Sign the DID Document with the default authentication key.
    document.sign(keypair.secret())?;

    // Use the Client to publish the DID Document to the Tangle.
    document.publish(client).await?;

    println!("DID document: {}", document);
    // Return document and keypair.
    Ok((document, keypair))
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(super::add(2, 2), 4);
    }
}
