import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*
import hudson.security.csrf.DefaultCrumbIssuer

if(!Jenkins.instance.isQuietingDown()) {
    def j = Jenkins.instance
    if(j.getCrumbIssuer() == null) {
        j.setCrumbIssuer(new DefaultCrumbIssuer(true))
        j.save()
        println 'CSRF Protection configuration has changed.  Enabled CSRF Protection.'
    }
    else {
        println 'Nothing changed.  CSRF Protection already configured.'
    }
}
else {
    println "Shutdown mode enabled.  Configure CSRF protection SKIPPED."
}
