# Docker & Kubernetes Assignment
The dags folder contains .py files for the dags created in correspondence to question-1. The .yaml files contains details of configuration required required for other tasks.

### Docker Task
1. Created a dag which adds the current time to the table at each run.
2. Below are importing statements required
      ```
      from airflow import DAG
      from datetime import datetime
      from airflow.providers.postgres.operators.postgres import PostgresOperator
      ```
3. Create table task, below is the code does it
    ```    
      create_table = PostgresOperator(
          task_id='create_table',
          postgres_conn_id='postgres',
          sql='''
              CREATE TABLE IF NOT EXISTS myTime (
                  curr_time TIMESTAMP
              );
          '''
      )
     ```
4. Insert table task, below is the code does it.
  ```
    insert_value = PostgresOperator(
        task_id = 'insert_value',
        postgres_conn_id='postgres',
        sql = '''
                INSERT INTO myTime VALUES (CURRENT_TIMESTAMP);   
        '''
    )
  ```
5. The following are the dependencies set in the dag.

```    
   create_table >> insert_value
```
### Snapshots
- Dag in the airflow
<img width="1376" alt="Screenshot 2023-06-15 at 12 08 58 PM" src="https://github.com/chakradharsrinivas16/Docker_Assignment/assets/123494344/3dbcfbea-4bb7-4eab-9dae-f001cd0dc2c5">

- Entries in the table
<img width="260" alt="Screenshot 2023-06-14 at 10 34 56 PM" src="https://github.com/chakradharsrinivas16/Docker_Assignment/assets/123494344/260f9ae8-f48e-4198-8622-03661c703d82">

### Kubernetes Task

Installed minikube to make a kubernetes cluster using the following commands.

```
brew install minikube
minikube start
```
Using the postgres-deployment.yaml file the pod containing postgres container was created.
To connect postgres and airflow install the dependencies in postgres container. We need to run below commands to open postgres container terminal.

```
kubectl apply -f postgres-deployment.yaml
minikube ssh
docker exec -it -u root postgres-container-id /bin/bash
```

```
apt-get -y update
apt-get  -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget 
wget https://www.python.org/ftp/python/3.7.12/Python-3.7.12.tgz
tar -xf Python-3.7.12.tgz
cd /Python-3.7.12
./configure --enable-optimizations
make -j $(nproc)
make altinstall
# STEPS TO INSTALL AIRFLOW VERSION 2.5.0
apt-get install libpq-dev
pip3.7 install "apache-airflow[postgres]==2.5.0" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.5.0/constraints-3.7.txt"
export AIRFLOW__CORE__SQL_ALCHEMY_CONN=postgresql://airflow:airflow@localhost:5432/airflow

airflow db init
airflow users create -u airflow -p airflow -f <fname> -l <lname> -e <mail> -r Admin
```

Then created a service of type clusterIP by running postgres-service.yaml to give access to postgres pods inside the cluster. The following command was used.

```
kubectl apply -f postgres-service.yaml
```

Using the airflow-deployment.yaml file the pod containing airflow container was made. The following command was used,
```
kubectl apply -f airflow-deployment.yaml
```

Creating dags and tasks in airflow scheduler.
```
minikube ssh
# for creating dag
docker exec -it -u root airflow-scheduler-id /bin/bash
cd dags
#installed vim by running these commands
apt-get update
apt install vim
vim time_task.py
# Write same dag file content here
```

Now, we can access the airflow webserver by running the command minikube service airflow. My airflow is accessible on below url Upon logging in, the dag was visible, then created a postgres connection and then ran my dag, it has been succesfully executed.

<img width="730" alt="Screenshot 2023-06-15 at 12 05 50 PM" src="https://github.com/chakradharsrinivas16/Docker_Assignment/assets/123494344/c82ec2cb-7004-49d5-8c50-cdde7f37e1ba">

Dag looks like this - 
<img width="1376" alt="Screenshot 2023-06-15 at 12 08 58 PM" src="https://github.com/chakradharsrinivas16/Docker_Assignment/assets/123494344/7a90b87f-d4d9-4ba1-9f83-9e63f2c2d3a0">

Validation of entry -

<img width="264" alt="Screenshot 2023-06-15 at 12 02 08 PM" src="https://github.com/chakradharsrinivas16/Docker_Assignment/assets/123494344/93ad704b-0543-4202-b667-1f8d66ba1c18">

