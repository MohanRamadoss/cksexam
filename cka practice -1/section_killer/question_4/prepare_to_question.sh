kubectl create ns team-red

echo "
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: docker-log-hacker
  name: docker-log-hacker
  namespace: team-red
spec:
  replicas: 1
  selector:
    matchLabels:
      app: docker-log-hacker
  strategy: {}
  template:
    metadata:
      name: docker-log-hacker
      labels:
        app: docker-log-hacker
    spec:
      containers:
      - image: nginx:alpine
        name: docker-log-hacker
        volumeMounts:
        - mountPath: /hacked-dir
          name: hacked-dir
      volumes:
      - name: hacked-dir
        hostPath:
          # directory location on host
          path: /var/lib/docker
          # this field is optional
          type: Directory
" > docker-log-hacker-pod.yaml

kubectl apply -f docker-log-hacker-pod.yaml