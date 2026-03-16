from cosmos import DbtDag
from cosmos.config import ProjectConfig, ProfileConfig
from datetime import datetime

dbt_dag = DbtDag(
    project_config=ProjectConfig(
        dbt_project_path="../ingest_project1"
    ),

    profile_config=ProfileConfig(
        profile_name="ingest_project1",
        target_name="dev",
        profiles_yml_filepath="../profiles.yml",
    ),

    schedule_interval="@daily",
    start_date=datetime(2024,1,1),
    catchup=False,
    dag_id="dbt_ingest_project1",
)