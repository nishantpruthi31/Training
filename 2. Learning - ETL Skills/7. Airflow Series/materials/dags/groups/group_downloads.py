from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.utils.task_group import TaskGroup
 
# this fxn will return our dag object , it needs 3 parametres 
# 1st - parent_dag_id , 2nd - child_dag_id , 3rd - args (some args need to be same between parent and child DAG like start dat etc)
def download_tasks():
        
        
        with TaskGroup("downloads",tooltip="Download tasks") as group:
                download_a = BashOperator(
        task_id='download_a',
        bash_command='sleep 10'
    )
                download_b = BashOperator(
        task_id='download_b',
        bash_command='sleep 10'
    )
                download_c = BashOperator(
        task_id='download_c',
        bash_command='sleep 10'
    )
        return group
                
                
    
        
        
        
        
 
    
 
    

             
             
            
    
