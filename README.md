# heroku-buildpack-git-deploy-keys
Heroku buildpack to let you use git deploy keys with your private repositories


1) Register a deploy key for a github repository
[Github Instructions](https://developer.github.com/guides/managing-deploy-keys/#deploy-keys)

2) Prepare your PRIVATE RSA key
**NOTE!!! PLEASE READ CAREFULLY**
You must take your ssh key, which could look like:
```
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAygnjqLkFx0zOlMn767nCegg/hGj7DGoffsQlobxjhFVzBE5t
396ib1EtSA/Y+uBjBDua3nP4F4ax1piigTP7031Z12xd3cjDwHvG25p1HRHO7ctJ
totvYfqUVjhYgBYHQHtcp/qScTG5byWl+PXfvmrPzet2etF01B90THYRn4ADRP35
Gn08kRczOImwp2nHncc3Z1Uk0G6Y3QaEB/b1wZN0RzlMLT/4im7+2zmkQnAqyK/q
ebOB+cnDQdiJ6dNEtfKJ1BUXtnr63Ku/wDG5T43eTJrl/OzlHETW88nT1m1Gb9O+
Q0Oc787rm1v2HvqZUZcUXoy4Ob6xF/oWbM5sgQIDAQABAoIBAHPMxULAgbJgsIsR
ViYe+3usXJONBE9ySAkFbbhM3RFNVLYkKc/FsH5zHawPAUOR9s7HRxW3jHwXhLjG
FWZOoEjwsNzLTOXAm4oop6rY1cVKnrsm6GILe1TCJeFhPEB138QysMHK2cKtSGaP
Qpj2fD6Mw/x3uBnfEcI/IQ5uId2zoeJA31Qa7IgnqxnpX9rN2861N9IcObah2RaZ
egNpKI9PBiYj3xe/frNH9jVR2JEsjbG+9FrgNLrgUShbjW0Qb++Av3oqm7gut3JZ
6aSfrYfVrD38C3AWSL84VvnVMjVWbwcFdjbBADdnhpwHutC+oN3b1qBRvT64zhvz
HG6HYO0CgYEA6UqtgvUgqnocCtI9D/MuTXqC61eVzqPtC6OdxwgngrIlHqn4je28
xriKc2ShmGR9jQHpSgmHER2nGqazxtcuahKT6yn6l7egcbcYSyGHj79fLOMXn5pG
0ld3epLYHAWrxz0C2/Mu+p2e9ROAF/Rf5AV8MF+QvvLVaQW+MnnSgO8CgYEA3bRt
CKOh2Y24o7lMcgFERXkEAyunyNBHWgL8W8fspWMxXoOJ+JiD5L3GywNjnh8UdioV
MtuCauHk2ChzyTIMplorZZExfQ2CnXnidSQSBLW4HxCEiilqmthCUMHv7OODhgtw
7Ja0iipHebTKDc0y4YnRn6wi0Q6oeg5CWUFQCY8CgYEAyI2eZHp+vo+DE/pw7AlO
wOSVL+R3sNFTszHRLY1hCgZDyvyr5LeAFgYHX/Qex3d8R4BhIXjXWGt5gHvXCRVr
nVyjNQM9nrgJgji49b25YGZQV7JSWK60O5dd603Z4x0s83cLwjJpLKHcSSuebvly
hgABJ0TAlqcDt+lr/NClmpkCgYAEZrGHa2AqJnMU5PfMh5PoYSegPHyfMutHsSl7
VPOwsNBpFOlnQvfTUaUhoJaYq/tHATzcfpkPMB7P37W0t8aigsW7xW8bEWqXX7UM
KEQnTcgy7awD5iCUpFhkrATsSfPxdEawm6lH2OEEXH9qWLl62raLmeozBjx399J/
XRmOpwKBgQC27NeVnWjSq+92cgjGenWeZEfb5lr39XHbypH2jswEwaHPnwb/VkyQ
6qd97dXoYILW05iFymkcNT9gESdm6FL5xRPVXJxBLm/mBSRJZyVYvEl0Ugp1T8Ft
9w5/JaN7yu0TS8WUB9QRSjuX/ntBN0Jf1+UqY5Vy/LMaqgzZJeCknw==
-----END RSA PRIVATE KEY-----
```

Remove both the BEGIN and END header/footer, and turn it into one big long string, so that it'll look like this:

```
MIIEpAIBAAKCAQEAygnjqLkFx0zOlMn767nCegg/hGj7DGoffsQlobxjhFVzBE5t396ib1EtSA/Y+uBjBDua3nP4F4ax1piigTP7031Z12xd3cjDwHvG25p1HRHO7ctJtotvYfqUVjhYgBYHQHtcp/qScTG5byWl+PXfvmrPzet2etF01B90THYRn4ADRP35Gn08kRczOImwp2nHncc3Z1Uk0G6Y3QaEB/b1wZN0RzlMLT/4im7+2zmkQnAqyK/qebOB+cnDQdiJ6dNEtfKJ1BUXtnr63Ku/wDG5T43eTJrl/OzlHETW88nT1m1Gb9O+Q0Oc787rm1v2HvqZUZcUXoy4Ob6xF/oWbM5sgQIDAQABAoIBAHPMxULAgbJgsIsRViYe+3usXJONBE9ySAkFbbhM3RFNVLYkKc/FsH5zHawPAUOR9s7HRxW3jHwXhLjGFWZOoEjwsNzLTOXAm4oop6rY1cVKnrsm6GILe1TCJeFhPEB138QysMHK2cKtSGaPQpj2fD6Mw/x3uBnfEcI/IQ5uId2zoeJA31Qa7IgnqxnpX9rN2861N9IcObah2RaZegNpKI9PBiYj3xe/frNH9jVR2JEsjbG+9FrgNLrgUShbjW0Qb++Av3oqm7gut3JZ6aSfrYfVrD38C3AWSL84VvnVMjVWbwcFdjbBADdnhpwHutC+oN3b1qBRvT64zhvzHG6HYO0CgYEA6UqtgvUgqnocCtI9D/MuTXqC61eVzqPtC6OdxwgngrIlHqn4je28xriKc2ShmGR9jQHpSgmHER2nGqazxtcuahKT6yn6l7egcbcYSyGHj79fLOMXn5pG0ld3epLYHAWrxz0C2/Mu+p2e9ROAF/Rf5AV8MF+QvvLVaQW+MnnSgO8CgYEA3bRtCKOh2Y24o7lMcgFERXkEAyunyNBHWgL8W8fspWMxXoOJ+JiD5L3GywNjnh8UdioVMtuCauHk2ChzyTIMplorZZExfQ2CnXnidSQSBLW4HxCEiilqmthCUMHv7OODhgtw7Ja0iipHebTKDc0y4YnRn6wi0Q6oeg5CWUFQCY8CgYEAyI2eZHp+vo+DE/pw7AlOwOSVL+R3sNFTszHRLY1hCgZDyvyr5LeAFgYHX/Qex3d8R4BhIXjXWGt5gHvXCRVrnVyjNQM9nrgJgji49b25YGZQV7JSWK60O5dd603Z4x0s83cLwjJpLKHcSSuebvlyhgABJ0TAlqcDt+lr/NClmpkCgYAEZrGHa2AqJnMU5PfMh5PoYSegPHyfMutHsSl7VPOwsNBpFOlnQvfTUaUhoJaYq/tHATzcfpkPMB7P37W0t8aigsW7xW8bEWqXX7UMKEQnTcgy7awD5iCUpFhkrATsSfPxdEawm6lH2OEEXH9qWLl62raLmeozBjx399J/XRmOpwKBgQC27NeVnWjSq+92cgjGenWeZEfb5lr39XHbypH2jswEwaHPnwb/VkyQ6qd97dXoYILW05iFymkcNT9gESdm6FL5xRPVXJxBLm/mBSRJZyVYvEl0Ugp1T8Ft9w5/JaN7yu0TS8WUB9QRSjuX/ntBN0Jf1+UqY5Vy/LMaqgzZJeCknw==
```

I've only tried this with normal RSA keys **without any lines** like the following in the head.
```
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: AES-128-CBC,36EBBE4008E18341AADDE660C6919ABF
```


2) Create a ```GITHUB_DEPLOY_KEY``` environment variable with the private key that you registered on your Heroku
[Heroku Instructions](https://devcenter.heroku.com/articles/config-vars#setting-up-config-vars-for-a-deployed-application)

3) Set your Heroku app's default buildpack to heroku-buildpack-multi
[Instructions](https://github.com/heroku/heroku-buildpack-multi)

4) Create a .buildpacks file if you already haven't in the root directory of your app. Make sure it includes this buildpack, and any other buildpacks you need. I'm using Ruby on Rails, so I have:

```sh
$ cat .buildpacks

https://github.com/siassaj/heroku-buildpack-git-deploy-keys
https://github.com/heroku/heroku-buildpack-ruby
```

5) Commit the .buildpacks file to your repository and push to Heroku. Cross fingers.
