# Install

First, install your specific, hardware, network packages into configuration.nix

Then run this script

```sh
git clone --recursive https://github.com/Riey/home.nix ~/.config/nixpkgs
# Optional change user name and home path
home-manager edit
# Optional test file
home-manager build
home-manager switch
```

