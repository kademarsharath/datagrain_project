FROM astrocrpublic.azurecr.io/runtime:3.1-13

# ENV UV_INDEX_URL=https://pypi.org/simple

# ENV UV_ALLOW_INSECURE_HOST=pip.astronomer.io

# ENV OPENLINEAGE_DISABLED=true


# # Create the virtual environment
# RUN python -m venv /usr/local/airflow/dbt_venv

# # Install dbt-databricks directly using the venv's pip
# # RUN /usr/local/airflow/dbt_venv/bin/pip install --no-cache-dir dbt-databricks


# RUN /usr/local/airflow/dbt_venv/bin/pip install --no-cache-dir \
#     --index-url https://pypi.org/simple \
#     dbt-databricks