# NOTE: 
# 1. pip install google-cloud-compute
# 2. python file_name.py
# ------------------------------------------------------------------------
# open CLOUD SHELL-->Open Editor-->create folder-->vm_restart.py-->create file-->vm.py-->copy & paste below code-->create file-->key.json-->copy paste content of service account key
# open-new_terminal-->pip install google-cloud-compute-->cd vm_restart.py-->python vm_.py (you can see that your vm is stopped and started)
# NOTE:
# 1. Make sure you have json key.
# 2. Give Project-Id and Zone
# -----------------------------------------------------------------------------------------------------------------------------------------------
# copy paste code in "GOOGLE SHELL" by creating a new file with ".py" extension.
#-----------------------------------------------------------------------------------------------------------------------------------------------

from google.cloud import compute_v1
import os

PROJECT_ID = 'keen-genius-415015'
ZONE = 'us-central1-a'

compute_client = compute_v1.InstancesClient()

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "key.json"


instances = compute_client.list(
    project=PROJECT_ID,
    zone=ZONE
)


for instance in instances:
    stop_instance_request = compute_client.stop(
        project=PROJECT_ID,
        zone=ZONE,
        instance=instance.name
    )
    stop_instance_request.result()

    print(f'Stopped VM instance: {instance.name}')