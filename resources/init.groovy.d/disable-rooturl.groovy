import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*

AdministrativeMonitor.all().get(jenkins.diagnostics.RootUrlNotSetMonitor.class).disable(true)
