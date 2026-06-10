'''

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

'''

class Car:
    max_speed=120
    
    def __init__(self,make,model,color,speed=0):
        self.make=make
        self.model=model
        self.color=color
        self.speed=speed
        
    def accelerate(self,accelaration):
        if self.speed+accelaration<= Car.max_speed:
            self.speed+=accelaration
        else:
            self.speed=Car.max_speed
            
    def get_speed(self):
        return self.speed
        
        
car1 = Car("Toyota", "Camry", "Blue")
car2 = Car("Honda", "Civic", "Red")


car1.accelerate(130)
car2.accelerate(20)


print(f"{car1.make} {car1.model} is currently at {car1.get_speed()} km/h.")
print(f"{car2.make} {car2.model} is currently at {car2.get_speed()} km/h.")
        
    