from airflow.decorators import dag, task
from datetime import datetime
import random

@dag(
    start_date=datetime(2023, 1, 1),
    schedule_interval='@daily',
    catchup=False,
    tags=['test_dag']
)
def task_api():
    
    @task
    def generate_random_number():
        number = random.randint(1, 100)
        print(f"Generated random number: {number}")
        return number 
    
    @task
    def check_even_odd(number):
        result = "even" if number % 2 == 0 else "odd"
        print(f"The number {number} is {result}.")

    check_even_odd(generate_random_number())


task_api()



