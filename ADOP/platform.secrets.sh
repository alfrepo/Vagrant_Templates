# Example file to store all the generated secrets for your ADOP stack

# Version ID of the example secrets file, note this needs to be the FULL SHA1 commit ID if you build this file by hand
# To do this by hand, run the following command: git log -1 --format='%H' HEAD platform.secrets.sh.example
export VERSION_ID="9e272ec14696c4b9fbb3ad6ce6870220874d875f"

# Username for initial admin user
export INITIAL_ADMIN_USER="user"

# Password for initial admin user
export INITIAL_ADMIN_PASSWORD_PLAIN="password"

# Password for the Jenkins user
export PASSWORD_JENKINS="password"

# Password for the Gerrit user
export PASSWORD_GERRIT="password"

# Root password for the Sonar and Gerrit MySQL instances
export PASSWORD_SQL="password"

# Admin password for LDAP
export LDAP_PWD="password"
