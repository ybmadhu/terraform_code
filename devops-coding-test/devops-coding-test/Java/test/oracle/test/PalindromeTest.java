package oracle.test;

/**
 * Provides sufficient test coverage for oracle.test.PalindromeUtil class.
 */
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class PalindromeUtilTest {

    @Test
    void testIsPalindrome() {
        // Test palindromes
        Assertions.assertTrue(PalindromeUtil.isPalindrome("anna"));
        Assertions.assertTrue(PalindromeUtil.isPalindrome("Madam, I'm Adam"));
        Assertions.assertTrue(PalindromeUtil.isPalindrome("12321"));

        // Test non-palindromes
        Assertions.assertFalse(PalindromeUtil.isPalindrome("hello"));
        Assertions.assertFalse(PalindromeUtil.isPalindrome(""));
        Assertions.assertFalse(PalindromeUtil.isPalindrome("12345"));
    }

    @Test
    void testFindLongestPalindrome() {
        // Test even-length palindrome
        String evenPalindrome = PalindromeUtil.findLongestPalindrome("babad");
        Assertions.assertTrue(evenPalindrome.equals("aba") || evenPalindrome.equals("bab"));

        // Test odd-length palindrome
        Assertions.assertEquals("anna", PalindromeUtil.findLongestPalindrome("anna"));

        // Test no palindrome
        Assertions.assertEquals("", PalindromeUtil.findLongestPalindrome("hello"));

        // Test palindrome with non-alphanumeric characters
        Assertions.assertEquals("", PalindromeUtil.findLongestPalindrome("Madam, I'm Adam"));
    }
}
