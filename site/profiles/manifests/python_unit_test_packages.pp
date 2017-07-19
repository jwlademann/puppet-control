# == Class: python unit test packages
#
# Installs tools required for running python unit tests
#
class profiles::python_unit_test_packages () {

  package {

  'setuptools':
    ensure   => latest,
    provider => 'pip3';

  'pytest-cov':
    ensure   => latest,
    provider => 'pip3';

  }

}
