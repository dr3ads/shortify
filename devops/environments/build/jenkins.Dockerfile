FROM jenkins/jenkins:lts
USER root

RUN groupadd docker --gid 993
RUN usermod -a -G root jenkins
RUN usermod -a -G docker jenkins

# drop back to the regular jenkins user - good practice
USER jenkins