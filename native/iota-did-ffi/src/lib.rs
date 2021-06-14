use allo_isolate::Isolate;
use tokio::runtime::{Builder, Runtime};
use lazy_static::lazy_static;
use std::io;

lazy_static! {
    static ref RUNTIME: io::Result<Runtime> = Builder::new()
        .threaded_scheduler()
        .enable_all()
        .core_threads(4)
        .thread_name("flutterust")
        .build();
}

/// Simple Macro to help getting the value of the runtime.
macro_rules! runtime {
    () => {
        match RUNTIME.as_ref() {
            Ok(rt) => rt,
            Err(_) => {
                return 0;
            }
        }
    };
}

#[no_mangle]
pub extern "C" fn add(a: i64, b: i64) -> i64 {
    iota_did::add(a, b)
}

#[no_mangle]
pub extern "C" fn create_did_document(port: i64) -> i32 {
    let rt = runtime!();
    let t = Isolate::new(port).task(iota_did::create_did_document());
    rt.spawn(t);
    1
}