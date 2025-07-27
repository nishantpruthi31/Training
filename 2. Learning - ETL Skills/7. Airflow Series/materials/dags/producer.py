from airflow import DAG, Dataset

from airflow.decorators import task
from datetime import datetime


myfile=Dataset("/tmp/my_file.txt")
myfile2=Dataset("/tmp/my_file2.txt")

with DAG(
    dag_id="producer",
    schedule_interval='@daily',
    start_date=datetime(2022,1,1),
    catchup=False
):
    @task(outlets=[myfile])    # this paramater indicates that this task updates our dataset i.e
                                 # whenever this task completes the task which depeneds on this dataset will be triggered.
    def update_dataset():
        with open(myfile.uri,"a+") as f:
            f.write("Producer update")
    
    #update_dataset()


    @task(outlets=[myfile2])    # this paramater indicates that this task updates our dataset i.e
                                 # whenever this task completes the task which depeneds on this dataset will be triggered.
    def update_dataset2():
        with open(myfile2.uri,"a+") as f:
            f.write("Producer update")
    
    #update_dataset2()


    update_dataset()>>update_dataset2()   # here the format to call tasks will be different i.e. when setting task dependency we need to have () also

