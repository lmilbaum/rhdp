#!groovy
import hudson.plugins.git.*;

def scm = new GitSCM("https://github.com/lioramilbaum/devopsloft.git")
scm.branches = [new BranchSpec("*/static_analysis")];

def flowDefinition = new org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition(scm, "Jenkinsfile")

def parent = Jenkins.instance
def job = new org.jenkinsci.plugins.workflow.job.WorkflowJob(parent, "devopsloft")
job.definition = flowDefinition

parent.reload()
