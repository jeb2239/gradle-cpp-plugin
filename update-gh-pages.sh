#!/usr/bin/env bash
if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo -e "Starting to update gh-pages\n"

  # load gradle.properties
  . ./gradle.properties

  #copy data we're interested in to other place
  cp -R build/spock-reports $HOME/spock-reports
  cp -R build/docs/groovydoc  $HOME/groovydoc


  #go to home and setup git
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis"

  #using token clone gh-pages branch
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/Tocea/gradle-cpp-plugin.git  gh-pages > /dev/null

  #go into diractory and copy data we're interested in to that directory
  cd gh-pages

	## test reports ############
   if [ ! -d "spock-reports/$version" ]; then
  # Control will enter here if $DIRECTORY exists.
  mkdir -p "spock-reports/$version"
  fi
  cp -Rf $HOME/spock-reports/* "spock-reports/$version"

  ## groovyDoc reports ############
  cd $HOME
  cd gh-pages
  if [ ! -d "groovydoc/$version" ]; then
  # Control will enter here if $DIRECTORY exists.
  mkdir -p "groovydoc/$version"
  fi
  cp -Rf $HOME/groovydoc/* "groovydoc/$version"

  #add, commit and push files
  git add -f .
  git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
  git push -fq origin gh-pages > /dev/null

  echo -e "Done magic with spock-reports\n"
fi
