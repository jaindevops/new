#!/bin/bash

pwd

#echo "jenkins build number is $build_number"

#gsutil cp gs://spinnaker-poc-artifact-bucket/spinnaker-gcp-"$build_number".tar .

sudo tar -xzf spinnaker-gcp-"$build_number".tar

sudo mv index.html /var/www/html

cd /var/www/html

#sudo sh -c "echo 'This is gcp spinnaker check' > index.html"

sudo rm -rf spinnaker-gcp-"$build_number".tar
