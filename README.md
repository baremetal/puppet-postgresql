puppet-postgresql
=================

Puppet manifest to configure PostgreSQL per Christophe Pettus's DjangoCon 2012 presentation, *PostgreSQL when it's not your job*.

The presentation can be found here:

http://thebuild.com/presentations/not-my-job-djangocon-us.pdf

How to use this thing
---------------------

At the moment this manifest is meant to be run without a Puppet server (to change soon).  Clone this repository in /etc/puppet/modules:

```
cd /etc/puppet/modules
git clone git://github.com/baremetal/puppet-postgresql.git postgresql
```

Then apply the manifest by running:

```
sudo puppet apply /etc/puppet/modules/postgresql/postgresql.pp
```
