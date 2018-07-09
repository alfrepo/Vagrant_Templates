

# Content
The Vagrant machine contains an Idea-Ultimate IDE trial.
Restart the Virtual machine, to maximize the window / run the UI as the non-root user "vagrant"


##  Login
Login / Password
```
vagrant/vagrant
```


##  GUI
Start the GUI
```
startx
```


##  Idea
Start idea as following
```
sudo bash /opt/idea-IU-173.4301.25/bin/idea.sh 
```


##  Import project
Import the project under
```
/home/vagrant/de.webapp.spring.one/
```

Use the "Import Project from external model" > "Gradle" option.
When asked for SDK - click on "add a new SDK" > JDK > choose "/usr/lib/jvm/java-8-openjdk-amd64/bin"

