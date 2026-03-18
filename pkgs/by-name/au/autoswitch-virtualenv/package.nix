{ lib, stdenv, fetchFromGitHub, pkgs, installShellFiles}:

stdenv.mkDerivation {
  pname = "autoswitch-virtualenv";
  version = "3.9.0";

  src = fetchFromGitHub {
    owner = "MichaelAquilina";
    repo = "zsh-autoswitch-virtualenv";
    rev = "3.9.0";
    sha256 = "sha256-j2YX+OcYbvS2G/KUNzcWbJepm9bZlegp1r8ZjcY6Nnw=";
  };

  dontBuild = true;
  nativeBuildInputs = [ installShellFiles ];
  installPhase = ''
    install -Dm755 autoswitch_virtualenv.plugin.zsh $out/autoswitch-virtualenv.plugin.zsh
  '';

  postPatch = ''
    substituteInPlace ./autoswitch_virtualenv.plugin.zsh \
      --replace "virtualenv" "${pkgs.virtualenv}/bin/virtualenv" \
      --replace "/usr/bin/stat" "${pkgs.coreutils}/bin/stat" \
      --replace "/bin/rm" "${pkgs.coreutils}/bin/rm" \
      --replace "/bin/ls" "${pkgs.coreutils}/bin/ls" \
      --replace "/bin/mkdir" "${pkgs.coreutils}/bin/mkdir"
  '';


  meta = {
    description = "A simple and quick ZSH plugin that switches python virtualenvs automatically as you move between directories.";
    homepage = "https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv";
    license = lib.licenses.gpl3;
    maintainers = [ lib.maintainers.dogethebeast ];
  };
}
