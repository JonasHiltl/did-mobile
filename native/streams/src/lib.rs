#![allow(dead_code)]
#![allow(unused_imports)]

mod structs;
mod utils;

use dotenv;
use iota_streams::{
    app::{
        message::HasLink,
        transport::tangle::client::{iota_client::bee_message::Error, Client},
        transport::tangle::{TangleAddress, PAYLOAD_BYTES},
    },
    app_channels::api::tangle::{
        Address, Author, ChannelType, MessageContent, Subscriber, Transport, UnwrappedMessage,
    },
    core::{panic_if_not, prelude::Rc, print, println, try_or, Errors::*, Result, LOCATION_LOG},
    ddml::types::*,
};
use utils::create_seed;

pub fn create_channel(credential: &str) -> Result<String, iota_streams::core::Error> {
    let seed = create_seed::new();

    // Create the Transport Client
    let client = Client::new_from_url(&dotenv::var("URL").unwrap());
    let mut author = Author::new(&seed, ChannelType::SingleBranch, client.clone());

    // Create the channel with an announcement message. Make sure to save the resulting link somewhere,
    let announcement_link = author.send_announce()?;

    // This link acts as a root for the channel itself
    let ann_link_string = announcement_link.to_string();

    // Author will now send signed encrypted messages in a chain
    let msg_inputs = vec![credential];

    let mut prev_msg_link = announcement_link;
    for input in &msg_inputs {
        let (msg_link, _seq_link) = author.send_signed_packet(
            &prev_msg_link,
            &Bytes::default(),
            &Bytes(input.as_bytes().to_vec()),
        )?;
        println!("Sent msg: {}", msg_link);
        prev_msg_link = msg_link;
    }
    Ok(ann_link_string)
}

#[cfg(test)]
mod tests {
}
