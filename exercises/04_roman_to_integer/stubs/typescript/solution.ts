// EXERCISE — Roman to Integer (TypeScript)
//
// Given a valid Roman numeral string, return its integer value.
//
//   Symbols:           I=1, V=5, X=10, L=50, C=100, D=500, M=1000
//   Subtractive pairs: IV=4, IX=9, XL=40, XC=90, CD=400, CM=900
//
//   romanToInt("III")      ->    3
//   romanToInt("LVIII")    ->   58
//   romanToInt("MCMXCIV")  -> 1994

export function romanToInt(s: string): number {
  throw new Error("implement romanToInt");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

test("three",           () => assert.equal(romanToInt("III"),          3));
test("subtractive_iv",  () => assert.equal(romanToInt("IV"),           4));
test("subtractive_ix",  () => assert.equal(romanToInt("IX"),           9));
test("lviii",           () => assert.equal(romanToInt("LVIII"),       58));
test("mcmxciv",         () => assert.equal(romanToInt("MCMXCIV"),   1994));
test("current_year",    () => assert.equal(romanToInt("MMXXIV"),    2024));
test("single_d",        () => assert.equal(romanToInt("D"),          500));
test("max",             () => assert.equal(romanToInt("MMMCMXCIX"), 3999));
