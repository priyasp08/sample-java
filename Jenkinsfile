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
 stage('Pre-Requirestion'){
  properties([[$class: 'BuildDiscarderProperty',strategy: [$class: 'LogRotator', numToKeepStr: '5']],disableConcurrentBuilds(),])
  echo("All environments=${env}")
  echo("\u2600 BUILD_URL=${env.BUILD_URL}")
  def workspace = pwd()
  echo("\u2600 workspace=${workspace}")
  mailnotification = "iamvj@gmail.com"
  //javaversion = 'JDK-1.8'
  //echo("\u2600 Java version=${javaversion}")
  branchname = "${env.BRANCH_NAME}"
  echo("\u2600 Branch Name=${branchname}")
  //sh ("git config --global user.email 'some@email.com'")
  //sh ("git config --global user.name 'jenkins'")
  //def url = sh(returnStdout: true, script: 'git config remote.origin.url').trim()
  echo("url = ${url}")
  def mvnHome = tool 'Maven-3.6'
  //def javahome = tool 'openjdk'
 }
 stage('Checkout'){
  echo "Git Checkout"
  checkout scm
 }
 stage('Build'){
  def mvnHome = tool 'Maven-3.6'
  //def javahome = tool 'openjdk'
  sh("${mvnHome}/bin/mvn -B -Dmaven.test.failure.ignore verify")
  }
 stage('SonarQube Ananlyis'){
  echo "Hi Sonar"
  withSonarQubeEnv('sonar'){
   def mvnHome = tool 'Maven-3.6'
   sh("${mvnHome}/bin/mvn sonar:sonar")
  }
 }
 stage('Docker Build'){
  def mvnHome = tool 'Maven-3.6'
  sh("${mvnHome}/bin/mvn package")
 }
 stage('Publish Image'){
  echo "Welclome Hub"
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
