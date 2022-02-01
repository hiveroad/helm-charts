# Kubernetes Helm charts

The home of Helm charts to deploy IOTA components to run on Kubernetes.

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add hiveroad https://hiveroad.github.io/helm-charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
hiveroad` to see the charts.

### Install Goshimmer
To install the goshimmer chart:

    helm install my-goshimmer hiveroad/goshimmer

To uninstall the chart:

    helm delete my-goshimmer

### Install Wasp

To install the wasp chart:

    helm install my-wasp hiveroad/wasp

To uninstall the chart:

    helm delete my-wasp
