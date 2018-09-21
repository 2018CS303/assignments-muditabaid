echo -n "Enter 'all' to delete all user containers or enter 'users' to delete some specific user container/containers: "
	read typ
  if [ "$typ" == "all" ]
  then
		echo -n "Enter the user list file: "
		read file
		while read user
			do
				docker rm $user
			done < $file
	else
    echo -n "Enter the usernames you want to delete and enter 'exit' after the deletion: "
    while read user
    	do
      	if ["$user" != "exit"]
        	then
          	dockeer rm $user
        else
          break
       fi
     done        
fi
