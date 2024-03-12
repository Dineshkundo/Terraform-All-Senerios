import pulumi
import pulumi_gcp as gcp

default = gcp.serviceaccount.Account("default",
    account_id="admin-416707",
    display_name="Custom SA for VM Instance")
default_instance = gcp.compute.Instance("default",
    network_interfaces=[gcp.compute.InstanceNetworkInterfaceArgs(
        access_configs=[gcp.compute.InstanceNetworkInterfaceAccessConfigArgs()],
        network="default",
    )],
    name="my-instance",
    machine_type="n2-standard-2",
    zone="us-central1-a",
    tags=[
        "foo",
        "bar",
    ],
    boot_disk=gcp.compute.InstanceBootDiskArgs(
        initialize_params=gcp.compute.InstanceBootDiskInitializeParamsArgs(
            image="debian-cloud/debian-11",
            labels={
                "my_label": "value",
            },
        ),
    ),
    scratch_disks=[gcp.compute.InstanceScratchDiskArgs(
        interface="NVME",
    )],
    metadata={
        "foo": "bar",
    },
    metadata_startup_script="echo hi > /test.txt",
    service_account=gcp.compute.InstanceServiceAccountArgs(
        email=default.email,
        scopes=["cloud-platform"],
    ))