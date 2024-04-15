{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, setuptools
, click
, lxml
, requests
, libretranslatepy
}:

buildPythonPackage rec {
  pname = "translate";
  version = "3.6.1";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-fnD/pG8ZPMdEvnyIuOEyPxD2sruQ0ku10p/fHlZhh4M=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    click
    lxml
    requests
    libretranslatepy
  ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace "'pytest-runner'" "" \

    substituteInPlace requirements.txt \
      --replace "libretranslatepy==2.1.1" "libretranslatepy"
  '';

  pythonImportsCheck = [
    "translate"
  ];

  nativeCheckInputs = [
  ];

  meta = with lib; {
    description = "Powerful translation tool written in python with with support for multiple translation providers.";
    homepage = "https://github.com/terryyin/google-translate-python";
    license = licenses.mit;
  };
}
