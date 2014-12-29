# OS X bootstrap

### Requirement

* MAC OS X (Yosemite)
* homebrew
* ansible

### Install Xcode

```
$ xcode-select -install
```

### Install homebrew

```
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Install ansible

```
$ brew install ansible
```

### Usage

```
$ ansible-playbook -i localhost main.yml -K
```
