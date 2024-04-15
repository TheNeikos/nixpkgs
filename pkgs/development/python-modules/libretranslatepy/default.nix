{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, setuptools
}:

buildPythonPackage rec {
  pname = "libretranslatepy";
  version = "2.1.3";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-b6hUqTMjEahwzjH4WzigBXqnjn6CT9ferEyMRIX1A24=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  pythonImportsCheck = [
    "libretranslatepy"
  ];

  nativeCheckInputs = [
  ];

  meta = with lib; {
    description = "Python bindings to connect to a LibreTranslate API";
    homepage = "https://github.com/argosopentech/LibreTranslate-py";
    license = licenses.mit;
  };
}
