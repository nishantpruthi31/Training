'''

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

'''

# Dict = {"key1": 1, "key2": "2", "key3": [3, 3, 3], "key4": (4, 4, 4), ('key5'): 5, (0, 1): 6}
# print(Dict[(0,1)])


# # dict .keys() and dict.values()
# print(Dict.keys())
# print(Dict.values())


# # deleting entry in dict
# del(Dict[(0,1)])
# print(Dict.keys())
# print(Dict.values())


# # inserting again

# Dict[(0,1)]=6
# print(Dict.keys())
# print(Dict.values())





# set1 = {"pop", "rock", "soul", "hard rock", "rock", "R&B", "rock", "disco"}
# print(set1)



# # creating a set from list
# album_list = [ "Michael Jackson", "Thriller", 1982, "00:42:19", \
#               "Pop, Rock, R&B", 46.0, 65, "30-Nov-82", None, 10.0]
# album_set = set(album_list)             
# print(album_set)



# A = set(["Thriller", "Back in Black", "AC/DC"])
# A.add("NSYNC")# a.remove() as well
# print(A)

# # to check if element is in A
# print("AC/DC" in A)



album_set1 = set(["Thriller", 'AC/DC', 'Back in Black'])
album_set2 = set([ "AC/DC", "Back in Black", "The Dark Side of the Moon"])

intersection = album_set1 & album_set2
print(intersection)


# Find the difference in set1 but not set2
print(album_set1.difference(album_set2) ) 

print(album_set1.union(album_set2))



