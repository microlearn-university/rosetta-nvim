// EXERCISE — Roman to Integer (Rust)
//
// Given a valid Roman numeral string, return its integer value.
//
//   Symbols:           I=1, V=5, X=10, L=50, C=100, D=500, M=1000
//   Subtractive pairs: IV=4, IX=9, XL=40, XC=90, CD=400, CM=900
//
//   roman_to_int("III")      ->    3
//   roman_to_int("LVIII")    ->   58   (L=50, V=5, III=3)
//   roman_to_int("MCMXCIV")  -> 1994   (M=1000, CM=900, XC=90, IV=4)

pub fn roman_to_int(s: &str) -> i32 {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn three() {
        assert_eq!(roman_to_int("III"), 3);
    }

    #[test]
    fn subtractive_iv() {
        assert_eq!(roman_to_int("IV"), 4);
    }

    #[test]
    fn subtractive_ix() {
        assert_eq!(roman_to_int("IX"), 9);
    }

    #[test]
    fn lviii() {
        assert_eq!(roman_to_int("LVIII"), 58);
    }

    #[test]
    fn mcmxciv() {
        assert_eq!(roman_to_int("MCMXCIV"), 1994);
    }

    #[test]
    fn current_year() {
        assert_eq!(roman_to_int("MMXXIV"), 2024);
    }

    #[test]
    fn single_d() {
        assert_eq!(roman_to_int("D"), 500);
    }

    #[test]
    fn max() {
        assert_eq!(roman_to_int("MMMCMXCIX"), 3999);
    }
}
