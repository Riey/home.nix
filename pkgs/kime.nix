{ pkgs, ... }:
with pkgs;
let
  qt5Version = qt5.qtbase.version;
  version = "2.1.3";
in stdenv.mkDerivation {
  pname = "kime";
  version = "${version}";
  src = fetchFromGitHub {
    owner = "Riey";
    repo = "kime";
    rev = "660ba9cb494f93c34043da29bc84efb34c70440a";
    sha256 = "1zcg24vny4r7qg5zfilzp4cwrfbvyha0y02q37989f068kpkvzx3";
  };
  buildInputs =
    [ glib pango atk gdk-pixbuf gtk3 libappindicator-gtk3 qt5.qtbase ];
  nativeBuildInputs = with rustPlatform; [
    rust.cargo
    rust.rustc
    cmake
    pkgconfig
    ninja
    qt5.wrapQtAppsHook
    clang
  ];

  rustpkgs = rustPlatform.buildRustPackage rec {
    inherit src version;
    name = "kime-${version}";
    cargoSha256 = "195g840m61l6diasxpwpickwg833h1pn7cx0dgf3zky5f7spg2kf";
    LIBCLANG_PATH = "${llvmPackages.libclang}/lib";
  };

  dontUseCmakeConfigure = true;

  meta = {
    description = "Korean IME";
    homepage = "https://github.com/Riey/kime";
    license = lib.licenses.gpl3;
    platforms = [ "x86_64-linux" ];
  };
}
