1. Build docker image with actions. Run `prepare.sh`
1. Deploy services to cluster `docker stack deploy --compose-file docker-stack.yml sara`
1. Run performance test `../performance/performance.sh`
1. Remove services `docker stack rm sara`
