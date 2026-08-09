# homebrew-tap

Personal Homebrew tap for [jasonmargin](https://github.com/jasonmargin).

## Use

```sh
brew tap jasonmargin/tap
brew install --cask dotch
```

## Layout

```
Casks/
└── dotch.rb    # AeroSpace workspaces in the MacBook notch
```

## Cutting a new cask version

In the [dotch](https://github.com/jasonmargin/dotch) repo:

```sh
just release 0.1.1     # builds + zips the .app, prints the gh release command
just bump-cask 0.1.1   # rewrites version + sha256 in Casks/dotch.rb
```

then commit and push this repo. Users get it via `brew upgrade --cask dotch`.
