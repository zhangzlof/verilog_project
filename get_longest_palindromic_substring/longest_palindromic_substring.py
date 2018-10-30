class Solution:
    def get_longest_palindromic_substring(self, s):
        """
        :type s: str
        :rtype: str
        """
        final_string = ""
        
        if len(s) <= 1:
            return s
            
        # if len(s) % 2 ==0:
        for i in range(len(s)-1):
            j=0
            while i-j >= 0 and (i+1)+j < len(s):
                if s[i-j] == s[(i+1)+j] :
                    if len(final_string) < len(s[i-j:(i+1)+j+1]):
                        final_string = s[i-j:(i+1)+j+1]
                else:
                    break
                j = j + 1
                
        
        # if len(s) % 2 ==1:
        for i in range(len(s)-1):
            j=0
            while i-j >= 0 and i+j < len(s):
                if s[i-j] == s[i+j]:
                    if len(final_string) < len(s[i-j:i+j+1]):
                        final_string = s[i-j:i+j+1]
                else:
                    break
                j = j + 1
                        
        return final_string