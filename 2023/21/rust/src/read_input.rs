use std::io::Read;

pub fn take_input() -> String {
    let mut input = Vec::new();
    let stdin = std::io::stdin();
    let mut handle = stdin.lock();
    handle.read_to_end(&mut input).unwrap();
    String::from_utf8(input).unwrap()
}
