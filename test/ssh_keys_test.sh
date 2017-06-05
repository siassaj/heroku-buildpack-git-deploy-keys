#! /bin/sh
. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh


afterSetUp()
{
    cp  ${BUILDPACK_HOME}/test/id_rsa ${ENV_DIR}/GIT_DEPLOY_KEY
}

testSSHKeysDroppedOnDisk()
{
  compile
  assertCapturedSuccess
  assertFileMD5 "b8e9a7bae8195a8812108a0a053e2918" "$HOME/.ssh/id_rsa"
  assertTrue "[ -e $HOME/.ssh/known_hosts ]"
}
