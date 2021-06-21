#![allow(dead_code)]
#![allow(unused_macros)]
#![allow(clippy::missing_safety_doc, clippy::not_unsafe_ptr_arg_deref)]

use ffi_helpers::null_pointer_check;
use lazy_static::lazy_static;
use std::{
    ffi::{CStr, CString},
    io,
    os::raw,
};
use tokio::runtime::{Builder, Runtime};

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
pub unsafe extern "C" fn last_error_length() -> i32 {
    ffi_helpers::error_handling::last_error_length()
}

#[no_mangle]
pub unsafe extern "C" fn error_message_utf8(buf: *mut raw::c_char, length: i32) -> i32 {
    ffi_helpers::error_handling::error_message_utf8(buf, length)
}

#[no_mangle]
pub extern "C" fn create_channel(credential: *const raw::c_char) -> String {
    let credential = unsafe { CStr::from_ptr(credential) };
    streams::create_channel(credential.to_str().unwrap()).unwrap()
}

/* #[no_mangle]
pub extern "C" fn create_did_document(port: i64) -> i32 {
    let rt = runtime!();
    let t = Isolate::new(port).task(streams::create_channel("credential"));
    rt.spawn(t);
    1
} */
