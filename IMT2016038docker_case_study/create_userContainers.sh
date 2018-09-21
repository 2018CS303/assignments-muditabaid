echo -n "Enter name of user list file: "
read file
while read user
	do
		docker create -it --name $user docker_trial_image /bin/bash
	done < $file
