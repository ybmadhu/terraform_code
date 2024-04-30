//package oracle.test;
/**
 * Checks if a string is a palindrome.
 *
 * Palindrome is a word, phrase or sentence that reads the same backward or
 * forward. For example, the following string is a palindrome: "Madam, I'm Adam."
 */
public class PalindromeUtil {
    public static boolean isPalindrome(String s) {
        if (s == null || s.isEmpty()) {
            return false;
        }

        // Remove non-alphanumeric characters and convert to lowercase
        String cleanedString = s.replaceAll("[^a-zA-Z0-9]", "").toLowerCase();

        // Check if the string is equal to its reverse
        return cleanedString.equals(new StringBuilder(cleanedString).reverse().toString());
    }

    public static String findLongestPalindrome(String s) {
        if (s == null || s.isEmpty()) {
            return "";
        }

        String longest = "";
        for (int i = 0; i < s.length(); i++) {
            // Odd-length palindrome (centered at s[i])
            String palindrome1 = expandAroundCenter(s, i, i);
            // Even-length palindrome (centered between s[i] and s[i+1])
            String palindrome2 = expandAroundCenter(s, i, i + 1);

            // Update the longest palindrome found
            if (palindrome1.length() > longest.length()) {
                longest = palindrome1;
            }
            if (palindrome2.length() > longest.length()) {
                longest = palindrome2;
            }
        }

        return longest;
    }

    private static String expandAroundCenter(String s, int left, int right) {
        while (left >= 0 && right < s.length() && s.charAt(left) == s.charAt(right)) {
            left--;
            right++;
        }
        return s.substring(left + 1, right);
    }

    public static void main(String[] args) {
        String inputString = "Madam, I'm Adam";
        System.out.println("Is it a palindrome? " + isPalindrome(inputString));
        
        String longPalindrome = findLongestPalindrome(inputString);
        System.out.println("Longest palindrome: " + longPalindrome);
    }
}
