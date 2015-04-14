FROM lazyfrosch/jenkins-slave:trusty
MAINTAINER Markus Frosch <markus.frosch@lazyfrosch.de>

# TODO: more restricting
RUN umask 0377 && echo "jenkins ALL = (root) NOPASSWD: ALL" > /etc/sudoers.d/jenkins

# Install RVM verified
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -O https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer && \
    curl -O https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer.asc && \
    gpg --verify rvm-installer.asc && \
    bash rvm-installer stable && \
    adduser jenkins rvm

# Install Ruby and Bundler
RUN \
    bash -c "source /etc/profile.d/rvm.sh && rvm install 1.9.3 --binary --fuzzy" && \
    bash -c "source /etc/profile.d/rvm.sh && rvm use 1.9.3 && gem install bundler"
