
from datetime import timedelta
from airflow.models import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago
import tarfile,csv

def unzip_data_files():
    file_path = "/home/project/airflow/dags/finalassignment/tolldata.tgz"
    extract_path = "/home/project/airflow/dags/finalassignment"

    with tarfile.open(file_path, "r:gz") as tar:
        tar.extractall(path=extract_path)
        print("Extraction complete.")

def extract_data_csv():
    input_path = "/home/project/airflow/dags/finalassignment/vehicle-data.csv"
    output_path = "/home/project/airflow/dags/finalassignment/staging/csv_data.csv"

    with open(input_path, mode='r') as infile,open(output_path, mode='w', newline='')as outfile:
        reader = csv.reader(infile)
        writer = csv.writer(outfile)
        for row in reader:
            # Extract columns: Rowid, Timestamp, Anonymized Vehicle number, Vehicle type
            writer.writerow([row[0], row[1], row[2], row[3]])

    print("csv_data.csv created without header.")

def extract_data_tsv():
    input_path = "/home/project/airflow/dags/finalassignment/tollplaza-data.tsv"
    output_path = "/home/project/airflow/dags/finalassignment/staging/tsv_data.csv"

    with open(input_path, mode='r') as infile, open(output_path, mode='w', newline='') as outfile:
        reader = csv.reader(infile, delimiter='\t')
        writer = csv.writer(outfile)
        for row in reader:
            writer.writerow([row[4], row[5], row[6]])

    print("tsv_data.csv created without header.")

def extract_data_fixed_width():
    input_path = "/home/project/airflow/dags/finalassignment/payment-data.txt"
    output_path = "/home/project/airflow/dags/finalassignment/staging/fixed_width_data.csv"

    with open(input_path, mode='r') as infile, open(output_path, mode='w', newline='') as outfile:
        for line in infile:
            parts = line.strip().split()
            #print(parts)
            #Safely get the last two fields
            type_of_payment_code = parts[-2]
            vehicle_code = parts[-1]
            outfile.write(f"{type_of_payment_code},{vehicle_code}\n")

    print("fixed_width_data.csv created using split().")

default_args={
    'owner':'Nishant',
    'start_date':days_ago(0),
    'email':'nishantpruthi12371@gmail.com',
    'email_on_failure':True,
    'email_on_retry':True,
    'retries':1,
    'retry_delay':timedelta(minutes=5)
}


dag=DAG(
    dag_id='ETL_toll_data',
    schedule_interval=timedelta(days=1),
    default_args=default_args,
    description='Apache Airflow Final Assignment',
    catchup=False
)


# task 1 to unzip the data
unzip_data= PythonOperator(
task_id='unzip',
python_callable=unzip_data_files,
dag=dag
)

# task 2 to csv data
extract_data_from_csv=PythonOperator(
    task_id='extract_from_csv',
    python_callable=extract_data_csv,
    dag=dag
)

# task 3 to tsv data
extract_data_from_tsv=PythonOperator(
    task_id='extract_from_tsv',
    python_callable=extract_data_tsv,
    dag=dag
)


# task4  extract data from fixed width file
extract_data_from_fixed_width=PythonOperator(
    task_id='extract_from_fixed_width',
    python_callable=extract_data_fixed_width,
    dag=dag
)


#task 5
consolidate_data=BashOperator(
task_id='consolidate_data_merge',
bash_command=
'paste /home/project/airflow/dags/finalassignment/staging/csv_data.csv \
/home/project/airflow/dags/finalassignment/staging/tsv_data.csv \
/home/project/airflow/dags/finalassignment/staging/fixed_width_data.csv \
> /home/project/airflow/dags/finalassignment/staging/extracted_data.csv',
dag=dag
)


# task 6 t
transform_data = BashOperator(
    task_id='transform_data_',
    bash_command=(
        "tr 'a-z' 'A-Z' < /home/project/airflow/dags/finalassignment/staging/extracted_data.csv "
        "> /home/project/airflow/dags/finalassignment/staging/transformed_data.csv"
    ),
    dag=dag,
)


# define pipeline
unzip_data>>extract_data_from_csv>>extract_data_from_tsv>>extract_data_from_fixed_width>>consolidate_data>>transform_data







