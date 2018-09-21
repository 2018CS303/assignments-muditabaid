echo -n "Enter the name of the container to be monitored: "
read name
docker logs -f $name
