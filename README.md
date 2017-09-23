# mongo
docker stack deploy -c docker-compose.yml mon

sed -i 's/\r$//' mongosetup.sh
docker cp mongosetup.sh $(docker ps -qf label=com.docker.swarm.service.name=mon_mongo1):/tmp/
docker exec -it $(docker ps -qf label=com.docker.swarm.service.name=mon_mongo1) chmod u+x /tmp/mongosetup.sh
docker exec -it $(docker ps -qf label=com.docker.swarm.service.name=mon_mongo1) sh /tmp/mongosetup.sh
