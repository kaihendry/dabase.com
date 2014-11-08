[[!meta title="'invalid value for project' google compute engine"]]

Google wasted my time by having a distinction between PROJECT NAME & PROJECT ID.

The SDK will ask you to set `gcloud config set project NAME`

NAME is the **PROJECT ID**

When things go wrong:

	ERROR: (gcloud.compute.instances.create) Some requests did not succeed:
	 - Invalid value for project: localkuvat

When things go right:

	$ gcloud config set project numeric-rig-758
	$ gcloud compute instances create outyet \
		--image container-vm-v20140925 \
		--image-project google-containers \
		--metadata-from-file google-container-manifest=containers.yaml \
		--tags http-server \
		--zone us-central1-a \
		--machine-type f1-micro
	Created [https://www.googleapis.com/compute/v1/projects/numeric-rig-758/zones/us-central1-a/instances/lk].
	NAME ZONE          MACHINE_TYPE INTERNAL_IP   EXTERNAL_IP    STATUS
	lk   us-central1-a f1-micro     10.240.89.159 146.148.60.109 RUNNING


Hat tip: <https://blog.golang.org/docker>
