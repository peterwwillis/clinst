# Changelog

## [2.5.0] - 2021-08-24
### Added
 - New extensions: ydiff, kind
 - New feature: '-D' option to switch default environment for an extension
### Changed
 - All new installed environments now have the version in the environment name
   to make it easier to switch the default environment.

---

## [2.4.0] - 2021-07-07
### Added
 - New extensions: kubectl, eksctl, helm, istioctl
 - New feature: install extensions from GitHub repos
### Changed
 - Renamed .CHECKSUMS.s256 to CHECKSUMS.sha256

---

## [2.3.1] - 2021-07-04
### Changed
 - Renamed the project *back* to cliv, because there is already a project
   named clenv... really I should have checked first :-X
 - Changes to release.sh
 - Update documentation
 - Simplify shellcheck tests

---

## [2.3.0] - 2021-07-02
### Added
 - Added new extensions: terragrunt, tfsec, tflint, terraform-docs
 - Added new variable *CLIV_E_BASEURL_ARGS* to be used by new internal extension
   function `_ext_url` (no longer need a dedicated url function in each extension)
 - Add a '-L' option to list extensions (& versions of extensions)
 - Add a .CHECKSUMS.s256 manifest with sha256 checksums of all files
 - Add a release.sh script to help with release process
### Changed
 - Extensions' url command can take options now (to be run outside of clenv)
 - Reformatted some code just to look pretty
 - *Extensions* now use a '.ex' file extension

---

## [2.2.0] - 2021-06-24
### Added
 - Add a `_ext_versions_ghreleases` function to get GitHub releases rather than tags
### Changed
 - If the environment variable `GITHUB_TOKEN` was set and is not empty, pass
   the Authorization: header to `curl` queries when getting tags or revisions
   from GitHub API. This will fix running into limits when running tests.
 - Stop checking for `wget`, only use `curl`
 - Modify the `_ext_versions_pypi` function to attempt to use either python or jq
   to parse versions via JSON. If that fails, use grep and sed.

---

## [2.1.2] - 2021-06-23
### Added
 - Add a 'versions' test for each extension
### Changed
 - DRYed some redundant test code into test.sh
### Fixed
 - Fixed the docker-compose extension to enable retrieving versions

---

## [2.1.1] - 2021-06-20

### Fixed
 - Add extra path for Ansible extension

---

## [2.1.0] - 2021-06-20

### Added
 - Common code from extensions incorporated into clenv functions
 - '-X' option to call internal clenv functions
 - More docs on how extensions work
### Changed
 - Refactored extension code
 - Refactored test code
### Fixed
 - GitHub Actions container fixed to run Ansible install

---

## [2.0.0] - 2021-06-19
### Added
 - Add ansible extension
 - Add '-q' mode to silence output
 - Add '-e' option
 - Add '-r' option
### Changed
 - Apply fewer permissions changes
 - Rename aws-cli extension to aws
 - Try not to overwrite wrappers unless CLIV_FORCE=1
 - No need to add '-I' option to install extensions
 - Rename '-I' to '-E'
 - Wrapper mode enabled by default; '-W' now disables
 - If version passed to '-E', don't check for version file
 - Updated docs
### Fixed
 - Fix an indefinite loop
 - Fix a version detection bug
 - Force mode now always copies latest extension code

---


## [1.3.0] - 2021-06-17
### Added
 - Test extension and core tests, including a test of the wrapper functionality.
 - GitHub Actions/Workflow to run CI tests on pull requests
### Changed
 - '-W' wrapper mode now requires an extension name. If the execution function
   is eventually run, that requires the environment name (and optional commands).
 - Each extension's binary file and wrapper names can now be overridden by passing
   *$CLIV_E_BIN_FILE*.
### Fixed
 - Wrapper mode would result in an infinite loop if one wrapper called another
   wrapper.
 - Terraform test only looks for the first version line now to work around notice
   about upgrading.

---

## [1.2.0] - 2021-06-16
### Added
 - `ADDME.md` (feature requests)
 - More documentation of how *Extensions* work
 - New extensions: aws-cli, docker-compose, packer, yq
### Changed
 - Change terminology "ALIAS" to "ENVIRON"
 - Install downloads into a ./download/ folder (simpler cleanup)
 - Install unpacked files into a ./usr/ folder
 - Install wrapper binaries as file named *$BIN_FILE* rather than *$CLIV_E_NAME*
 - Simplify some environment variables used by download (OS, ARCH, etc)
 - In extensions, `$CLIV_E_INSTDIR` defaults to current directory

---

## [1.1.0] - 2021-06-16
### Added
 - saml2aws extension and test
 - CHANGELOG.md

---

## [1.0.0] - 2021-06-16
### Added
 - Terraformer extension and test
 - Some docs on the version wrapper functionality
### Changed
 - Tests are refactored to be a little simpler
 - Renamed project from cliv to clenv
### Fixed
 - Wrapper functionality should work better now (but still isn't 100% - see FIXME.md)
