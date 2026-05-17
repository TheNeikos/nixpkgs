{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage (finalAttrs: {
  pname = "codedown";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "earldouglas";
    repo = "codedown";
    rev = "1fa97cc806b6bdfc07ed637e179808e0f6d4a4e7";
    hash = "sha256-Bc+AAg806ZlpcYyhqcq62Nc5vJfRXijG76irvc8GVFY=";
  };

  npmDepsHash = "sha256-MZ2yEf44Eo9HtHQf8oabtkusyeKVJac1prAoMA5HdLE=";

  dontNpmBuild = true;

  meta = {
    description = "Aa utility to extract code blocks from Markdown files";
    homepage = "https://github.com/earldouglas/codedown";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ hemera ];
  };
})
