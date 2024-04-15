{ lib
, buildPythonPackage
, fetchPypi
, ffms
, pytestCheckHook
, setuptools
, numpy
}:

buildPythonPackage rec {
  pname = "ffms2";
  version = "0.4.5.5";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Pf2bKgB4YpcjWXyzc1h5Wj04WO/7S3dg9gw6FzrVBSk=";
  };

  patches = [
    ./ffms_nix_store.patch
  ];

  postPatch = ''
    substituteInPlace ffms2/libffms2.py      \
      --replace 'FFMS2_NIX_STORE_PATH' "${ffms}/lib/libffms2.so" \
  '';

  nativeBuildInputs = [
    setuptools
  ];

  nativePropagatedBuildInputs = [
    ffms
  ];

  propagatedBuildInputs = [
    numpy
  ];

  pythonImportsCheck = [
    "ffms2"
  ];

  nativeCheckInputs = [
  ];

  meta = with lib; {
    description = "Python bindings for FFmpegSource";
    homepage = "https://github.com/bubblesub/pyffms2";
    license = licenses.lgpl3;
  };
}
