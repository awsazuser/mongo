#mong docker image build 
sed -i 's/\r$//' mongosetup.sh
docker build -t mongo349 .

# mongo
docker stack deploy -c docker-compose.yml mon


wget https://raw.githubusercontent.com/mongodb/docs-assets/primer-dataset/primer-dataset.json
docker cp primer-dataset.json $(docker ps -qf label=com.docker.swarm.service.name=mon_mongo1):/tmp/
docker exec -it $(docker ps -qf label=com.docker.swarm.service.name=mon_mongo1) mongoimport --db newdb --collection restaurants --file /tmp/primer-dataset.json
