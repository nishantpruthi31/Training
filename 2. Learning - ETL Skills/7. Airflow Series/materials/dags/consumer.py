from airflow import DAG, Dataset
from airflow.decorators import task
from datetime import datetime

myfile=Dataset("/tmp/my_file.txt")
myfile2=Dataset("/tmp/my_file2.txt")




with DAG(
    dag_id="consumer",
    schedule=[myfile,myfile2] ,  # it means as soon as Producer DAG updates the my_file Dataset , it will be triggered
    start_date=datetime(2022,1,1),
    catchup=False  
):
    
    @task 
    def read_dataset():
        with open(myfile.uri,"r") as f:
            print(f.read())
    
    read_dataset()