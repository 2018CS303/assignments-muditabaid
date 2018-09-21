echo -n "Enter username: "
read name
docker start $name
docker attach $name
