-- Algorithm registry. Each entry describes a language-agnostic exercise and
-- lists which languages ship a stub. Working copies live under the data dir,
-- keyed on (algorithm id, language).

return {
  {
    id          = '01_binary_search',
    title       = 'Binary Search',
    module      = 'searching',
    type        = 'implement',
    description = 'Given a sorted array and a target, return the index of the target, or -1 (None in Rust) if not present. Must run in O(log n) — the tests assume binary search, not linear.',
    hints = {
      'Invariant: if target is in arr, it lies in arr[lo..=hi]. Shrink this range each iteration until lo > hi.',
      'Compute mid = lo + (hi - lo) / 2 — not (lo + hi) / 2 — to avoid integer overflow for large ranges.',
      'Three cases: arr[mid] == target → return mid; arr[mid] < target → search the right half (lo = mid + 1); else search the left half (hi = mid - 1).',
    },
    languages = { 'python', 'rust', 'go', 'typescript' },
  },
  {
    id          = '02_two_sum',
    title       = 'Two Sum',
    module      = 'hashing',
    type        = 'implement',
    description = 'Given an array of integers and a target, return the indices (i, j) with i < j of the two distinct elements that sum to target. Exactly one solution exists. Aim for O(n) — the hash-map pattern beats the O(n²) brute force.',
    hints = {
      'Brute force is two nested loops — correct, but O(n²). The unlock is trading time for space with a hash map.',
      'Single pass: for each nums[i], ask "have I already seen target - nums[i]?". If yes, you have your pair; if no, record (nums[i] → i) and keep going.',
      'Because you record *after* the lookup, the earlier index is always the map hit and the current index is i — so the map gives you i and the loop gives you j, with i < j for free.',
    },
    languages = { 'python', 'rust', 'go', 'typescript' },
  },
  {
    id          = '03_max_subarray',
    title       = 'Maximum Subarray',
    module      = 'dynamic-programming',
    type        = 'implement',
    description = "Given a non-empty array of integers (may include negatives), return the largest sum of any contiguous subarray. Classic DP — Kadane's algorithm runs in O(n). Watch the all-negative case: you must pick at least one element.",
    hints = {
      'Scan left-to-right tracking two numbers: best_here (max subarray sum ending at current index) and best_seen (global max so far).',
      'At each element: best_here = max(nums[i], best_here + nums[i]). Either extend the running subarray or abandon it and start fresh at nums[i] — whichever is larger.',
      'Initialize both best_here and best_seen to nums[0], then iterate from index 1. This naturally handles all-negative inputs — you never reset to 0, so a negative max stays negative.',
    },
    languages = { 'python', 'rust', 'go', 'typescript' },
  },
  {
    id          = '04_roman_to_integer',
    title       = 'Roman to Integer',
    module      = 'strings',
    type        = 'implement',
    description = 'Given a valid Roman numeral string, return its integer value. Symbols: I=1, V=5, X=10, L=50, C=100, D=500, M=1000. Subtractive pairs: IV, IX, XL, XC, CD, CM. Inputs are well-formed (no "IIII" or "VX"), 1 to 3999.',
    hints = {
      'Start by building a lookup from single symbol to value. Everything else is just "how do I handle IV / IX / CM?".',
      "Subtractive trick: walk left to right. If value(s[i]) < value(s[i+1]), subtract it; otherwise add it. Example: IX = -1 + 10 = 9. MCMXCIV = 1000 - 100 + 1000 - 10 + 100 - 1 + 5 = 1994.",
      'The last character has no right neighbour, so it\'s always added. Guard the lookahead with a bounds check, or iterate to len-1 and add the final value separately.',
    },
    languages = { 'python', 'rust', 'go', 'typescript' },
  },
}
