{ lib
, stdenv
, fetchFromGitLab
, python3
, ffmpeg
, qt6
}:

python3.pkgs.buildPythonApplication rec {
  pname = "subtitld";
  version = "23.02";
  pyproject = true;

  src = fetchFromGitLab {
    owner = "jonata";
    repo = pname;
    rev = "${version}";
    hash = "sha256-MS9pXfr2xkuqBdBNHdWDK654yJ14zag4l1DVa/gji30=";
  };

  patches = [
    ./remove-debug-mpv-option.patch
  ];

  nativeBuildInputs = [
    qt6.wrapQtAppsHook
  ];

  # Makes qt-wayland appear in the qt paths injected by the wrapper - helps users
  # with `QT_QPA_PLATFORM=wayland` in their environment.
  buildInputs = [
    qt6.qtbase
  ] ++
  lib.optionals (stdenv.isLinux) [
    qt6.qtwayland
  ];

  propagatedBuildInputs = with python3.pkgs; [
    setuptools
    pyside6
    pyopengl
    numpy
    cffi
    requests
    pycaption
    pysubs2
    html5lib
    speechrecognition
    beautifulsoup4
    python-docx
    chardet
    google-api-python-client
    pysrt
    certifi
    python-i18n
    google-cloud-core
    #
    ffms2
    python3.pkgs.mpv
    clean-text
    translate
  ];

  postPatch = ''
    substituteInPlace setup.py                                    \
      --replace 'beautifulsoup4<4.10,>=4.8.1' 'beautifulsoup4'    \
      --replace 'numpy==1.24.0' 'numpy'                           \
      --replace 'python-mpv==0.5.2' 'mpv'                  \
      --replace 'PySide6==6.3.2' 'PySide6'                        \
      --replace 'html5lib==1.0b8' 'html5lib'
  '';

  # Project has no tests
  doCheck = false;

  meta = with lib; {
    description = "Software to create, edit and transcribe subtitles";
    mainProgram = "subtitld";
    homepage = "https://gitlab.com/jonata/subtitld";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ];
  };
}
