{ lib
, buildPythonPackage
, fetchPypi
, fetchFromGitHub
, pytestCheckHook
, poetry-core
, emoji
, ftfy
}:

buildPythonPackage rec {
  pname = "clean-text";
  version = "0.6.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-g3SzhfwqJuBjg/Yq7Qdvpr4RXlgyI54qf9izRPqNKrI=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    (emoji.overrideAttrs (old: {
      version = "1.7.0";
      src = fetchFromGitHub {
        owner = "carpedm20";
        repo = "emoji";
        rev = "refs/tags/v1.7.0";
        hash = "sha256-vKQ51RP7uy57vP3dOnHZRSp/Wz+YDzeLUR8JnIELE/I=";
      };
    }))
    ftfy
  ];

  postPatch = ''
    substituteInPlace pyproject.toml        \
      --replace 'poetry>=0.12' 'poetry-core' \
      --replace 'poetry.masonry.api' 'poetry.core.masonry.api'
  '';

  pythonImportsCheck = [
    "cleantext"
  ];

  nativeCheckInputs = [
  ];

  meta = with lib; {
    description = "Preprocess your scraped data with clean-text to create a normalized text representation.";
    homepage = "https://github.com/jfilter/clean-text/";
    license = licenses.asl20;
  };
}
