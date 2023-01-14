class Solution:
    def lenghtOfLongestSubstring(self, s):
        sub_string = ""
        for index in range(len(s)):
            has_repeated = False
            attempt = ""
            for letter in s[index::]:
                if attempt.count(letter) == 0 and has_repeated == False:
                    attempt = attempt + letter
                else:
                    has_repeated = True
            if len(attempt) > len(sub_string):
                sub_string = attempt
        return sub_string


x = Solution()

print(x.lenghtOfLongestSubstring("pwwkew"))
