#!/usr/bin/env groovy

import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL
import org.jenkinsci.plugins.gitclient.Git;
import org.jenkinsci.plugins.gitclient.GitClient;
 
try {
node {
 
 stage('Checkout'){
  echo "Git Checkout"
  checkout scm
 }
 stage('Build'){
  def mvnHome = tool 'Maven-3.6'
  //def javahome = tool 'openjdk'
  sh("${mvnHome}/bin/mvn -B verify -Dmaven.test.skip=true")
  }
 stage('SonarQube Analysis'){
  echo "Hi Sonar"
  withSonarQubeEnv('sonar-6'){
   def mvnHome = tool 'Maven-3.6'
   sh("${mvnHome}/bin/mvn sonar:sonar")
  }
 }
 
 stage('Docker Build approval'){
    input "Proceed For Build"
}
 stage('Docker Build'){
  def mvnHome = tool 'Maven-3.6'
  sh("${mvnHome}/bin/mvn package")
 }
 stage('Publish Image'){
  echo "Welclome Hub"
  def mvnHome = tool 'Maven-3.6'
  sh 'docker login -u 471108 -p Priyasp*08'
  sh("${mvnHome}/bin/mvn dockerfile:push")
 }
} // node
 
} // try end
catch (exc) {
/*
 err = caughtError
 currentBuild.result = "FAILURE"
 String recipient = 'infra@lists.jenkins-ci.org'
 mail subject: "${env.JOB_NAME} (${env.BUILD_NUMBER}) failed",
         body: "It appears that ${env.BUILD_URL} is failing, somebody should do something about that",
           to: recipient,
      replyTo: recipient,
 from: 'noreply@ci.jenkins.io'
*/
} finally {
  
 (currentBuild.result != "ABORTED") && node("master") {
     // Send e-mail notifications for failed or unstable builds.
     // currentBuild.result must be non-null for this step to work.
     //step([$class: 'Mailer',
     //   notifyEveryUnstableBuild: true,
     //   recipients: "${email_to}",
     //   sendToIndividuals: true])
 }
}
