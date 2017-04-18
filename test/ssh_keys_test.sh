#! /bin/sh
. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh


afterSetUp()
{
  cp  ${BUILDPACK_HOME}/test/id_rsa ${ENV_DIR}/GITHUB_DEPLOY_KEY
}

testSSHKeysDroppedOnDisk()
{
  compile
  assertCapturedSuccess
  assertFileMD5 "b8e9a7bae8195a8812108a0a053e2918" ~/.ssh/id_rsa
  assertTrue "[ -e ~/.ssh/known_hosts ]"
}
