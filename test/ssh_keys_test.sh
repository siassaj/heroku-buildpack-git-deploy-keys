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
  assertFileMD5 "c36450c2b759b174a55e6ed4f113eada" "$HOME/.ssh/private_key"
  assertTrue "[ -e $HOME/.ssh/known_hosts ]"
}
