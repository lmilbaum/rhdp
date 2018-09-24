#!groovy
import hudson.security.*
import jenkins.model.*

def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
def users = hudsonRealm.getAllUsers()
users_s = users.collect { it.toString() }

def env = System.getenv()

jenkins_admin_user = env['JENKINS_ADMIN_USER']
jenkins_admin_pass = env['JENKINS_ADMIN_PASS']

// Create the admin user account if it doesn't already exist.
if (jenkins_admin_user in users_s) {
    println "Admin user already exists - updating password"

    def user = hudson.model.User.get('jenkins_admin_user');
    def password = hudson.security.HudsonPrivateSecurityRealm.Details.fromPlainPassword('jenkins_admin_pass')
    user.addProperty(password)
    user.save()
}
else {
    println "--> creating local admin user"

    hudsonRealm.createAccount(jenkins_admin_user,jenkins_admin_pass)
    instance.setSecurityRealm(hudsonRealm)

    def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
    instance.setAuthorizationStrategy(strategy)
    instance.save()
}
