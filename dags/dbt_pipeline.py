import os
from datetime import datetime ,timedelta
from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig
# Use the Token mapping class instead
from cosmos.profiles import DatabricksTokenProfileMapping 


default_args = {
    "retries": 2,
    "retry_delay": timedelta(minutes=2),
    "retry_exponential_backoff": True,
    "max_retry_delay": timedelta(minutes=30),
    "execution_timeout": timedelta(minutes=60),
    "email": ["kademarsharath@gmail.com"],
    "email_on_failure": True,
    "email_on_retry": False,
    # "on_failure_callback": notify_slack
}   



ENV = os.getenv("DBT_ENV", "dev").lower()

ENV_CFG = {
    "dev": {
        "target_name": "dev",
        "conn_id": "databricks_dev_conn",
        "catalog": "workspace",
        "schema": "dbt_project",
        "http_path": "/sql/1.0/warehouses/b55efce1f1fee952",
    },
    "prod": {
        "target_name": "prod",
        "conn_id": "databricks_prod_conn",
        "catalog": "workspace_prod",
        "schema": "dbt_project",
        "http_path": "/sql/1.0/warehouses/b55efce1f1fee952",
    },
}

if ENV not in ENV_CFG:
    raise ValueError(f"Invalid DBT_ENV={ENV}")

cfg = ENV_CFG[ENV]

profile_config = ProfileConfig(
    profile_name="ingest_project1",
    target_name=cfg["target_name"],
    profile_mapping=DatabricksTokenProfileMapping(
        conn_id=cfg["conn_id"],
        profile_args={
            "catalog": cfg["catalog"],
            "schema": cfg["schema"],
            "http_path": cfg["http_path"],
            "auth_type": "token",
        },
    ),
)

print(f"[INFO] Running dbt in ENV={ENV}, catalog={cfg['catalog']}")


# Profile config using the Token mapping
# profile_config = ProfileConfig(
#     profile_name="ingest_project1",
#     target_name="dev",
#     profile_mapping=DatabricksTokenProfileMapping(
#         conn_id="databricks_conn",   # <-- pulls token from Airflow
#         profile_args={
#             "catalog": "workspace",
#             "schema": "dbt_project",
#             "http_path": "/sql/1.0/warehouses/b55efce1f1fee952", 
#             "auth_type": "token"
#         },
#     ),
# )


dbt_dag = DbtDag(
    dag_id="dbt_ingest_project1",
    project_config=ProjectConfig("/usr/local/airflow/ingest_project1"),
    profile_config=profile_config,
    operator_args={
        "disable_openlineage": True, # This kills the KeyError: 'version' noise
    },
    execution_config=ExecutionConfig(
        dbt_executable_path="/usr/local/airflow/dbt_venv/bin/dbt",
    ),
    schedule="@daily",
    start_date=datetime(2024, 1, 1),
    catchup=False,

    max_active_runs=1,     # ✅ only one DAG run at a time
    max_active_tasks=5,    
    dagrun_timeout=timedelta(hours=2),
    default_args=default_args

)