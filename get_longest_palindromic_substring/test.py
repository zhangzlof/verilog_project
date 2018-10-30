def get_longest_palindromic_substring(s):
	length=len(s)
	max_length=0
	max_substribf=""
	for i in range(length):

		if(s[i]==s[i+1]):
			for j in range(1,length):
				if ((i-j==0)  or (i+j+1)==length-1):
					if(s[i-j]==s[i+1+j]):
					    substring_length=2*(j+1)
					    longest_substring=s[i-j:i+j+2]
					else:
                                            substring_length=2*j
					    longest_substring=s[i-j+1:i+j+1]
				else:
					if(s[i-j]!=s[i+1+j]):
					    substring_length=2*j
					    longest_substring=s[i-j+1:i+j+1]
		else:
			for j in range(1,length):
				if ((i-j==0)  or (i+j)==length-1):
					if(s[i-j]==s[i+j]):
						substring_length=2*j+1
					        longest_substring=s[i-j:i+j+1]
					else:
						substring_length=2*(j-1)+1
					        longest_substring=s[i-j+1:i+j]
				else:
					if(s[i-j]!=s[i+1+j]):
						substring_length=2*(j-1)+1
						longest_substring=s[i-j+1:i+j]

		if(substring_length>=max_length):
			max_length=substring_length
			max_substring=longest_substring
	return max_substring
