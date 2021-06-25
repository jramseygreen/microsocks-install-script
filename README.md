# microsocks-install-script
A script to download, compile and configure [microsocks](https://github.com/rofl0r/microsocks) as a service on ubuntu.

## Bare in mind
I created and tested this only on Ubuntu-20.04 but I suspect it will work for any Debian based release.
This only gives the bare minimum in options to the user - what port to use and username and password. The proxy server is run on all (0.0.0.0) as documented on the microsocks page.
A systemd service is created with your inputs for the username, password and port to use.

To reconfigure these options, simply run the install script again with ```./microsocks-install.sh```

## Dependencies
This requires you to have unzip, gcc and wget - all of which should be downloaded for you if not present.

# Installation
simply run 
```
wget "https://raw.githubusercontent.com/jramseygreen/microsocks-install-script/main/microsocks-install.sh" && sudo bash microsocks-install.sh
```
