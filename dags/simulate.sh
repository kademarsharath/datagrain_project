
#!/usr/bin/env bash

# Simulate a feature branch
echo "---- Simulating feature branch ----"
export DBT_ENV=dev
python dbt_pipeline.py

echo ""
echo "---- Simulating main branch (prod) ----"
export DBT_ENV=prod
python dbt_pipeline.py


