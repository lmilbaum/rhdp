import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*
import jenkins.model.GlobalConfiguration
import jenkins.CLI

CLI cli = GlobalConfiguration.all().get(CLI.class)
cli.setEnabled(true);
cli.save()

AdministrativeMonitor.all().get(jenkins.CLI$WarnWhenEnabled.class).disable(true)
