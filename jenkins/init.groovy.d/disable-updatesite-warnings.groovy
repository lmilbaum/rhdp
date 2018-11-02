import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*

AdministrativeMonitor.all().get(jenkins.security.UpdateSiteWarningsMonitor.class).disable(true)
