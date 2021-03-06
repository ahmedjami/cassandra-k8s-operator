#!/bin/bash -e

testScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${testScriptDir}

source ../util.sh


createDgossVolumes
# Add test file to user config map
createInitConfigContainer
createPreRunConfigMapFile
createCassandraBootstrapContainer 
#createAndCheckCassandraContainer #comment to go quicker

# check using test specific `goss.yaml`
GOSS_SLEEP=0 dgoss run \
          -v ${BOOTSTRAP_VOLUME}:/etc/cassandra \
          -v ${EXTRA_LIB_VOLUME}:/extra-lib \
          ${CASSANDRA_IMAGE}
