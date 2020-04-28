# Changelog

## [2.1.0](https://github.com/PeterMosmans/git-template/compare/v2.0.1...v2.1.0) (2020-04-28)


### Features

* **installer:** make the use of installerrc file more visible ([c9c70df](https://github.com/PeterMosmans/git-template/commit/c9c70dffedf1776ff5153466140d6a2bbba1c591))
* **installer:** replace rst-lint with doc8 ([15da912](https://github.com/PeterMosmans/git-template/commit/15da91272285dd71284ca231f1c72cc10f596a85))
* **pre-commit:** replace rst-lint with doc8 ([2df3c85](https://github.com/PeterMosmans/git-template/commit/2df3c85ad17f71079b78dbdc1c94b0559f466f2d))
* **yamllint:** add settings file compatible with prettier ([b0ca5a1](https://github.com/PeterMosmans/git-template/commit/b0ca5a15d2e2cd43cbc92f86ccc2ea74031962bd))
* **yamllint:** install yamllint settings file ([25af833](https://github.com/PeterMosmans/git-template/commit/25af833a92572bd54eea041cda0f826e4a159337))


### Bug Fixes

* **hooks:** use correct yamllint flags ([f69b4d4](https://github.com/PeterMosmans/git-template/commit/f69b4d4baf01cb6dccc316b1f39cc3d6381943e6))
* **installer:** use correct name for jinja linter ([50af153](https://github.com/PeterMosmans/git-template/commit/50af1530377f6ce84e6daf914dcbfc11bbc09b8d))
* **pre-commit:** use correct flags for xmllint ([d927bd0](https://github.com/PeterMosmans/git-template/commit/d927bd0100aabd8df981bd54ad44d5b8aea45f80))

### [2.0.1](https://github.com/PeterMosmans/git-template/compare/v2.0.0...v2.0.1) (2020-04-22)

## [2.0.0](https://github.com/PeterMosmans/git-template/compare/v1.2.0...v2.0.0) (2020-04-22)


### ⚠ BREAKING CHANGES

* **pre-commit:** Use a less confusing and more standard name; lint-jinja.

### Features

* **pre-commit:** rename Jinja validator script ([7d3ecee](https://github.com/PeterMosmans/git-template/commit/7d3eceea6b7b2cdbb66b8d9bee41a527c619f46f))
* **pre-commit:** use proper regular expressions for extensions ([a04cd7f](https://github.com/PeterMosmans/git-template/commit/a04cd7f5cbc007aee496438858aee8170b5fa31e))
* add support for .precommitrc INIFILE ([d3c8dc9](https://github.com/PeterMosmans/git-template/commit/d3c8dc9dd0cae9aba700d48748cc0b5ac1674d16))
* add support for .precommitrc INIFILE ([eb5d376](https://github.com/PeterMosmans/git-template/commit/eb5d37676e140ca9ecb1d8a6b4470cd61367670b))

## [1.2.0](https://github.com/PeterMosmans/git-template/compare/v1.1.0...v1.2.0) (2020-04-13)


### Features

* **pre-commit:** add shellcheck ([bdcbd6a](https://github.com/PeterMosmans/git-template/commit/bdcbd6ab629294c1be4f2beb9d5ba58d1da720be))


### Bug Fixes

* **pre-commit:** ensure branch can be read from empty repository ([feff4d9](https://github.com/PeterMosmans/git-template/commit/feff4d96450666f820c98e655f77f88f95a7467c))
* **pre-commit:** quote filenames ([8015f86](https://github.com/PeterMosmans/git-template/commit/8015f86ddd4712e8a7daf249174a79be97a3c605))
* **pre-commit:** use double quotes to prevent globbing and splitting ([debdefd](https://github.com/PeterMosmans/git-template/commit/debdefdb638318fe8f805c457f25e749ca874387))

## 1.1.0 (2020-04-10)


### Features

* **hooks:** add pre-commit and commit-msg hooks ([48126a4](https://github.com/PeterMosmans/git-template/commit/48126a43d849303720fb2620dbd3fc65b77dcaeb))
* **hooks:** add Python lint ([f87f969](https://github.com/PeterMosmans/git-template/commit/f87f9690e2603e49962fa7b0a63fd3a7a0949dfa))
* **hooks:** add reStructuredText linter ([87080b4](https://github.com/PeterMosmans/git-template/commit/87080b4ed50dddab4187252869b0a1b77bd6d7e2))
* **hooks:** add verbose messages when validating filetypes ([ade3d79](https://github.com/PeterMosmans/git-template/commit/ade3d7954bebd42a4c870a51d2ea56e72957c3f0))
* **hooks:** add XML linter ([6e68f99](https://github.com/PeterMosmans/git-template/commit/6e68f99ed63b4b73089be183b735840a52c4a9f4))
* **hooks:** add YAML linter ([030e240](https://github.com/PeterMosmans/git-template/commit/030e2409ebcc0dce5132159fe6f5eb13ec29e297))
* **hooks:** check whether linter exists before linting ([fb9bc5f](https://github.com/PeterMosmans/git-template/commit/fb9bc5f259a9ef1077bf344fde0abfc69c53954c))
* **installer:** split installer file into settings and script ([d6331d7](https://github.com/PeterMosmans/git-template/commit/d6331d768f0b73a5a7643d9b61da5e21f222f759))
* **pre-commit:** allow master commits for CHANGELOG.md ([eb648ae](https://github.com/PeterMosmans/git-template/commit/eb648aeb4f69de9b8e8bff80055da45079dfd987))
* **pre-commit:** enable check for type of branch ([4402b8b](https://github.com/PeterMosmans/git-template/commit/4402b8bcb5e6e5815c59637d927ae159fd669b03))
* **pre-commit:** prevent (non-tag) commits to master branch ([5c8c973](https://github.com/PeterMosmans/git-template/commit/5c8c9738e7e1075c59664c1e576208a2ddd6620f))
* **pre-commit:** run hooks from anywhere ([068640e](https://github.com/PeterMosmans/git-template/commit/068640ea2d3433f5a70436e5ed44f941f7df2987))
* **prettier:** add basic prettier configuration and rules ([47a10e0](https://github.com/PeterMosmans/git-template/commit/47a10e02cac6718f59b2958ca761366a5b60d835))
* **prettier:** add basic prettierignore ruleset ([b12c741](https://github.com/PeterMosmans/git-template/commit/b12c741e3c92599171f81ea3703a7a24bafa5fcc))
* add basic installer ([7e5f1f7](https://github.com/PeterMosmans/git-template/commit/7e5f1f7bf27a91e7b2400d9408ac1fb97dbba421))
* add default configurations ([7c9db8c](https://github.com/PeterMosmans/git-template/commit/7c9db8c63f8739aed1e6555bfcf45c8a32b47afb))


### Bug Fixes

* **hooks:** ensure only certain files/extensions are validated ([865d04c](https://github.com/PeterMosmans/git-template/commit/865d04cb69cd3ee9823d5c334eca22fe6fbb54dd))
* **hooks:** exit as soon as a test fails ([c8105a0](https://github.com/PeterMosmans/git-template/commit/c8105a09d9adaa24daaa8490a6fe1fb9fd3c94e4))
* **pre-commit:** ensure CHANGELOG.md can be committed ([52ad52e](https://github.com/PeterMosmans/git-template/commit/52ad52ec2787de12b78f72ec77696225e2d3a8a7))
* **standard-version:** ensure prettier compatibility with changelog ([6495aa9](https://github.com/PeterMosmans/git-template/commit/6495aa900741d9aee4081e66d32bff2bc0a42517))

## [1.3.0](https://github.com/PeterMosmans/git-template/compare/v1.2.0...v1.3.0) (2020-04-09)


### Features

* **pre-commit:** allow master commits for CHANGELOG.md ([eb648ae](https://github.com/PeterMosmans/git-template/commit/eb648aeb4f69de9b8e8bff80055da45079dfd987))


### Bug Fixes

* **pre-commit:** ensure CHANGELOG.md can be committed ([52ad52e](https://github.com/PeterMosmans/git-template/commit/52ad52ec2787de12b78f72ec77696225e2d3a8a7))

## [1.2.0](https://github.com/PeterMosmans/git-template/compare/v1.1.0...v1.2.0) (2020-04-09)


### Features

* **hooks:** check whether linter exists before linting ([fb9bc5f](https://github.com/PeterMosmans/git-template/commit/fb9bc5f259a9ef1077bf344fde0abfc69c53954c))
* **pre-commit:** enable check for type of branch ([4402b8b](https://github.com/PeterMosmans/git-template/commit/4402b8bcb5e6e5815c59637d927ae159fd669b03))
* **pre-commit:** prevent (non-tag) commits to master branch ([5c8c973](https://github.com/PeterMosmans/git-template/commit/5c8c9738e7e1075c59664c1e576208a2ddd6620f))
* **pre-commit:** run hooks from anywhere ([068640e](https://github.com/PeterMosmans/git-template/commit/068640ea2d3433f5a70436e5ed44f941f7df2987))

## [1.1.0](///compare/v1.0.0...v1.1.0) (2020-03-23)


### Features

* **hooks:** add Python lint f87f969
* **hooks:** add reStructuredText linter 87080b4
* **hooks:** add verbose messages when validating filetypes ade3d79
* **hooks:** add XML linter 6e68f99
* **hooks:** add YAML linter 030e240
* **prettier:** add basic prettier configuration and rules 47a10e0
* add basic installer 7e5f1f7
* add default configurations 7c9db8c


### Bug Fixes

* **hooks:** exit as soon as a test fails c8105a0

## 1.0.0 (2020-03-03)


### Features

* **hooks:** add pre-commit and commit-msg hooks 48126a4


### Bug Fixes

* **hooks:** ensure only certain files/extensions are validated 865d04c
