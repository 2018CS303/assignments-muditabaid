# **Docker Case Study**

## **Problem** - Automate Infra allocation for Learning and Development

### **Requirements:**
- Dynamic Allocation of Linux systems for users
- Each user should have independent Linux System
- Specific training environment should be created in Container
- User should not allow to access other containers/images
- User should not allow to access docker command
- Monitor participants containers
- Debug/live demo for the participants if they have any doubts/bug in running applications.
- Automate container creation and deletion.
All the above requirements are same as mentioned in slides.

## Create the container image
1. Create a new container from a base image of your choice.
  `docker create -it --name test_docker ubuntu /bin/bash `

2. Start and attach to container.
    ```
    docker start docker_trial
    docker attach docker_trial
    ```

3. Install packages required for the students. (e.g. vim, gcc )
    ```
    apt update
    apt install vim
    apt install nano
    apt install gcc
    ```

4. Create `questions.txt` and `instructions.txt` required for training and then save them.

5. Commit the container:
    `docker commit -a "Mudita Baid" 16508e5c265d docker_trial_image`

Training container image is ready now.


## Allocate Containers to Users
1.  To dynamically allocate the users a linux system create a shell script `create_userContainers.sh` to automatically create docker containers using a specific environment docker image for every user.

    - `users.txt`
        ```
        Nimisha
        Shreya
        Akshi
        Apoorva
        ```
    - `create_userContainers.sh`
        ```sh
        echo -n "Enter name of user list file: "
        read file
        while read user
          do
            docker create -it --name $user docker_trial_image /bin/bash
          done < $file
        ```
2.  Run the shell script `create_userContainers.sh` and fill the entries in `users.txt`. This creates a docker container corresponding to each username from `user.txt`.
3.  The user can then use the allocated container using `userContainer.sh` script.
    - `userContainer.sh`
        ```sh
        echo -n "Enter username: "
        read name
        docker start $name
        docker attach $name
        ```
4.  This allows user to enter to his/her allocated Linux system and has only access to the bash of that system.

## Monitor the container
- We can monitor the containers live using the `monitorContainer.sh` script which helps us when we(or anyone) have any doubts/bug in the running application.

    - `monitorContainer.sh`
        ```sh
        echo -n "Enter the name of the container to be monitored: "
        read name
        docker logs -f $name
        ```

## Automating deletion of the containers
- Automate the deletion using the `deleteContainers.sh` script.

    - `deleteContainers.sh`
        ```sh
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
        ```
- This gives two options i.e. to either delete all users containers at once or delete a specific user/users by name.

## Ensuring that the users cannot access others users' containers:

Add the following lines to every user's .bashrc
```
docker start -ai <name>
exit
```
When the user connects to the system, the user will directly connect to the docker container. When he/she exits the container, the next command "exit" forces the user to exit the system itself, without a chance to access other containers.


**Note:** To run any shell script in the terminal use the following command:
```
sh <shell script>
```
or  
```
bash <shell script>
```
