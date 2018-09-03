# Assignment_2_1 : Exploring Jenkins

## Jenkins
Jenkins is an open source automation server, written in Java. It provides `continuous integration` services for software development with the help of plugins. Plugins allows to integrate the various stages in the devops workflow.

`Continuous Integration` is a development practice in which developer is required to make frequent commits to the source code in a day. Every time a commit is made in the source repository, it is automatically built and tested, providing developer the test results of every commit made.

## Blue Ocean
Blue Ocean rethinks the User Experience(UX) of Jenkins.  It is designed to make Jenkins UI more efficient by reducing clutter and increasing the clarity. Its main features include Sophisticated visualizations, Pipeline editor, Personalisation.

### Installing Blue Ocean
- From the administrator account, go to `Manage Jenkins -> Manage Plugins`.
- Install `Blue Ocean (BlueOcean Aggregator)` plugin from the list of `Available` plugins.
- Restart Jenkins: `sudo service jenkins restart`
- Blue Ocean will be activated when Jenkins restarts.
- To use the Blue Ocean UI choose the `Blue Ocean` option from the left menu.

## Building a private GitHub Repository

- Create a private repository on Github.
- Log-in to Jenkins and create a new freestyle project.
- Under `Source Code Management` select `Git`.
- Add the private repository's URL in the `Repository URL` section.
- Since the repository is private, Jenkins will not be able to access the repo without credentials. So, we must give Jenkins permission to access the repository. Click on `Add` button next to `Credential` text box. Choose `Jenkins` as the Credential Provider in the dropdown menu. 
- Choose `Username with Password` under the `Kind` option. Provide your GitHub "Username" and "Password" under their respective text boxes.
- Once they are added select them from the dropdown menu for `Credentials`.
- This will link jenkins to your private repository.

## Using Git SCM Poll
Using SCM Poll, Jenkins will check periodically (with mentioned time) if new commits are made and if they are made then it will build the changed version. Whereas, using Git SCM Poll, it will create link between Github and Jenkins, therefore, Jenkins will come to know when new commits are made and will build only then, making it more efficient.

### Configuring build triggers
- Go to the project for which you need to implement Git SCM polling.
- Go to `Configure -> Build Triggers`.
- Select `GitHub hook trigger for GITScm polling` and save
configuration.

###Getting a public URL for Jenkins
- The tool `ngrok` helps us achieve this.
- Download the setup `ngrok` from [here](https://ngrok.com/download).
- Run `./ngrok http 8080`. This will give our local host a public IP Address which should be used at webhook in settings of Jenkins.

### Activating Jenkins service to GitHub
Now we need to set up our GitHub repo to make a request to Jenkins webhook so that the polling logic can be applied. 
- Go to GitHub repo and then go to `Settings -> Integrations & services`.
- Click on `Add service` and choose `Jenkins (GitHub plugin)` from the list.
- Add your local url (given by ngrok) `http://<hook given by ngrok>/github-webhook` under `Jenkins hook url`.
- Select the `Active` checkbox and click on `Add Service` button.
- Now GitHub should make a request to the Jenkins webhook and cause a build (if required) to occur.

## Post Build Actions - Extended Email Notification
Steps to setup Extended Email Notifications as a post build action have beendocumented below. Extended Email Notifications allow us to send customized email notifications after the build process.

### Configuring Email
We need to first add the details of the SMTP server and the mail account so  that Jenkins can send the mail.

- Go to `Manage Jenkins -> Configure Systems` and scroll down to the `Extended E-mail Notification` section.
- Add the SMTP server details of the email you want to use to send e-mails (e.g. `smtp.gmail.com`).
- Click on the `Advanced` button to configure the mail account.
- Select `Use SMTP Authentication`.
- Enter the account username under `User Name` and password under `Password`.
- Select `Use SSL` and specify the `SMTP port` (465 in most cases).
- Select `Allow sending to unregistered users` if mail should be sent to non-Jenkins users.
- With this the basic email configuration is complete. 
- We can also customize the mail sent. (e.g. we can specify the list of default recipients and default content). 
- Jenkins injects certain variables like `$PROJECT_NAME`, `$BUILD_NUMBER` and `$BUILD_STATUS` which can be used in the content to get dynamic values.

### Adding the post build action
- Go to `Configuration` page of project.
- Scroll down to `Post-build Actions`.
- Click on `Add post-build action` and choose `Editable Email Notification` from dropdown menu.
- Jenkins once again provides the default settings through variables (e.g. `$DEFAULT_RECIPIENTS`, `$DEFAULT_SUBJECT` and `$DEFAULT_CONTENT`).
- The options can be used for project based customizations of the email notification.
- The `Advanced` settings can be used for specifying triggers i.e. conditions under which the notification should be sent (e.g. On every failed build).
- Apply and save changes.

With this the Post build action for extended email notification is complete.
