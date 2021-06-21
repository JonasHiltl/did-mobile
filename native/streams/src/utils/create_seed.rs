use rand::Rng;

pub fn new() -> String {
    let alph9 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ9";
    let seed: String = (0..10)
        .map(|_| {
            alph9
                .chars()
                .nth(rand::thread_rng().gen_range(0, 27))
                .unwrap()
        })
        .collect::<String>();
    seed
}
