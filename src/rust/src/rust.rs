use std::ffi::c_int;
use std::ffi::CStr;
use std::ffi::CString;
use std::os::raw::c_char;
use std::time::Instant;

#[no_mangle]
pub extern "C" fn check_elapsed_time(
    // n-th prime calculation function
    func_ptr: extern "C" fn(c_int) -> c_int,
    lang_name: *const c_char,
) {
    const N: c_int = 200_000;
    let start = Instant::now();
    let n_th_prime = func_ptr(N);
    let duration = start.elapsed();
    let lang_name = unsafe { CStr::from_ptr(lang_name) }.to_str().unwrap();
    println!(
        "{} th prime is {}. from \x1b[32m{}\x1b[0m. Elapsed time: \x1b[32m{:?}\x1b[0m",
        N, n_th_prime, lang_name, duration
    );
}

extern "C" {
    fn hello_c();
}

#[no_mangle]
pub extern "C" fn hello_rust() {
    println!("Hello, world! from Rust");
    let lang_name = CString::new("Rust").unwrap();
    check_elapsed_time(n_th_prime, lang_name.as_ptr());
    unsafe { hello_c() }
    println!("Exiting Rust...")
}

pub extern "C" fn n_th_prime(n: c_int) -> c_int {
    let n = n as usize;
    let mut count: usize = 1;
    let mut current_n = 2;
    loop {
        if is_prime(current_n) {
            if count == n {
                return current_n as c_int;
            }
            count += 1;
        }
        current_n += 1
    }
}

fn is_prime(n: usize) -> bool {
    if n == 2 {
        return true;
    }
    if n % 2 == 0 {
        return false;
    }
    let mut i = 3;
    while i * i <= n {
        if n % i == 0 {
            return false;
        }
        i += 2;
    }
    true
}
