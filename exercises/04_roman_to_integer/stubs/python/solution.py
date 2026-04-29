# EXERCISE — Roman to Integer (Python)
#
# Given a valid Roman numeral string, return its integer value.
#
#   Symbols:           I=1, V=5, X=10, L=50, C=100, D=500, M=1000
#   Subtractive pairs: IV=4, IX=9, XL=40, XC=90, CD=400, CM=900
#
#   roman_to_int("III")      ->    3
#   roman_to_int("LVIII")    ->   58   (L=50, V=5, III=3)
#   roman_to_int("MCMXCIV")  -> 1994   (M=1000, CM=900, XC=90, IV=4)


def roman_to_int(s):
    raise NotImplementedError("implement roman_to_int")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


class TestRomanToInt(unittest.TestCase):
    def test_three(self):
        self.assertEqual(roman_to_int("III"), 3)

    def test_subtractive_iv(self):
        self.assertEqual(roman_to_int("IV"), 4)

    def test_subtractive_ix(self):
        self.assertEqual(roman_to_int("IX"), 9)

    def test_lviii(self):
        self.assertEqual(roman_to_int("LVIII"), 58)

    def test_mcmxciv(self):
        self.assertEqual(roman_to_int("MCMXCIV"), 1994)

    def test_current_year(self):
        self.assertEqual(roman_to_int("MMXXIV"), 2024)

    def test_single_d(self):
        self.assertEqual(roman_to_int("D"), 500)

    def test_max(self):
        self.assertEqual(roman_to_int("MMMCMXCIX"), 3999)


if __name__ == "__main__":
    unittest.main()
