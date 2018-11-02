#!groovy
import hudson.model.UpdateCenter;
import hudson.model.UpdateSite;
import hudson.util.PersistedList;
import jenkins.model.Jenkins

replace_site('https://updates.jenkins.io/experimental/update-center.json')
Jenkins.instance.updateCenter.getPlugin("warnings").deploy(true).get()
Jenkins.instance.restart()

def replace_site(String site) {
  PersistedList<UpdateSite> sites = Jenkins.getInstance().getUpdateCenter().getSites();
  for (UpdateSite s : sites) {
   if (s.getId().equals(UpdateCenter.ID_DEFAULT))
     sites.remove(s);
  }
  sites.add(new UpdateSite(UpdateCenter.ID_DEFAULT, site));
  Jenkins.instance.pluginManager.doCheckUpdatesServer()
  Jenkins.instance.save()
}
