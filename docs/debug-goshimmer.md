# Goshimmer debugging tips n' tricks

## Test UDP connectivity

In first window:

```bash
kubectl run -i -t --rm --restart=Never --image ubuntu temp /bin/bash
apt-get update && apt-get install -y netcat

nc -u -l 14626
```

In second window:

```bash
kubectl expose pod temp --port=14626 --protocol=UDP --name=temp --type=NodePort

nc -u $(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}') $(kubectl get service temp --output jsonpath='{.spec.ports[0].nodePort}')

# type something and you should see the text show up in the first window
```
