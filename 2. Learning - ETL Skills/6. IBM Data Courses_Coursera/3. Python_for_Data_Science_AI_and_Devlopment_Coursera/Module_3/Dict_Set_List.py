'''

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

'''
givenstring="Lorem ipsum dolor! diam amet, conseteturLorem magna. sed diam nonumy eirmod tempor. Lorem diam et labore? et diam magna. et diam amet."

class TextAnalyzer(object):
    def __init__(self, text):
        formattedText = text.replace('.','').replace('!','').replace('?','').replace(',','')
        formattedText = formattedText.lower()
        self.fmtText=formattedText
        
    def freqall(self):
        listwords=self.fmtText.split(' ')
        print(listwords)
        
        s=set(listwords)
        print(s)
        
        dictofwords={}
        
        for item in s:
            if item in dictofwords:
                dictofwords[item] += 1
            else:
                dictofwords[item] = 1
            
        print(dictofwords)
        




#if __name__ == "__main__":
  #  main()
    
if __name__ == "__main__":
    t1=TextAnalyzer(givenstring)
    t1.freqall()