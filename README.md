# Kubernetes Helm charts

The home of Helm charts to deploy IOTA components to run on Kubernetes.

[Helm](https://helm.sh) must be installed to use the charts. Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

    helm repo add hiveroad https://hiveroad.github.io/helm-charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
hiveroad` to see the charts.

## Goshimmer

Goshimmer chart requires that the Kubernetes cluster support NodePorts and NodePorts are accessible by other peers. The ports are used for autopeering and gossip protocol.

### Install Goshimmer

To install the goshimmer chart:

    helm install my-goshimmer hiveroad/goshimmer --set goshimmer.dashboard.auth.enabled=false

> Note: We disable the dashboard authentication until the annoying [bug](https://github.com/iotaledger/goshimmer/pull/1986) is fixed.

Open tunnel to the dashboard:

    kubectl port-forward service/my-goshimmer 8081:dashboard

And go to <http://localhost:8081> to view the dashboard. Wait a moment, and slowly you start to see it connecting to neighbours, and messages start to flow. You should see `TangleTime Synced: Yes` when it gets synchronised with other nodes.

### Persisted Goshimmer identity

By default, every time the pod restarts, it creates a new identity for the node. If you want to use a static GoShimmer identity, create a seed and pass it via `goshimmer.seed` config:

    helm install my-goshimmer hiveroad/goshimmer \
      --set goshimmer.dashboard.auth.enabled=false \
      --set goshimmer.seed=<SEED HERE>

### Uninstall Goshimmer

To uninstall the goshimmer chart:

    helm delete my-goshimmer

### Goshimmer FAQ

#### You get an error “Please check that GoShimmer is publicly reachable at port ….”

The Goshimmer requires that the node be accessible from the public internet, and the Helm deployment uses the Service NodePorts to provide a port number to which other peers can connect.

The error message indicates that the node ports (by default 30000-40000) are not accessible. Ensure that there’s no firewall or something else blocking the access.

## Wasp

### Install Wasp

To install the wasp chart:

    helm install my-wasp hiveroad/wasp --set wasp.goshimmerAddress=<hostname:port>

> Note: If you're using the Goshimmer chart in same cluster, you can use the `<chart-name>-network:5000` as a goshimmer address.

Open tunnel to the dashboard:

    kubectl port-forward service/my-wasp 7000:dashboard

And go to <http://localhost:7000> to view the dashboard. Login credentials are by default `wasp/wasp`.

### Uninstall Wasp

To uninstall the chart:

    helm delete my-wasp
