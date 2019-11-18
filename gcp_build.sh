#!/bin/bash

pwd

echo "jenkins build number is $build_number"

gsutil cp gs://spinnaker-poc-artifact-bucket/spinnaker-gcp-"$build_number".tar .

sudo mv spinnaker-gcp-"$build_number".tar /var/www/html

cd /var/www/html

#sudo sh -c "echo 'This is gcp spinnaker check' > index.html"

sudo tar -xzf spinnaker-gcp-"$build_number".tar

sudo rm -rf spinnaker-gcp-"$build_number".tar
