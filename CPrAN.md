# NAME

**CPrAN** - A package manager for Praat

# SYNOPSIS

    use CPrAN;
    CPrAN->run;

# DESCRIPTION

**CPrAN** is the parent class for an App::Cmd application to search, install,
remove and update Praat plugins.

As a App::Cmd application, use of this module is separated over a number of
different files. The main script invokes the root module and executes it, as in
the example given in the SYNOPSIS.

**CPrAN** commands (inhabiting the **CPrAN::Command** namespace) can call the
methods described below to perform general **CPrAN**-related actions.

# METHODS

- make\_root()

    Makes the **CPrAN** root directory.

    - is\_cpran()

        Takes an object of type Path::Class and checks whether it is a **CPrAN** Praat
        plugin. See _is\_plugin()_ for the criteria they need to fulfill ot be a plugin.

        In order to be considered a **CPrAN** plugin, a valid plugin must additionally
        have a _plugin descriptor_ written in valid YAML.

        This method does not currently make any sanity checks on the structure of the
        plugin descriptor (which should follow the example bundled in _example.yaml_),
        but future versions might.

    - is\_plugin()

        Takes an object of type Path::Class and checks whether it is a Praat plugin. All
        directories that reside under Praat's preferences directory, and whose name
        begins with the _plugin\__ identifier are considered valid plugins.

            use Path::Class;
            is_plugin( file('foo', 'bar') );           # False
            is_plugin( dir('foo', 'bar') );            # False
            is_plugin( dir($prefdir, 'bar') );         # False
            is_plugin( dir($prefdir, 'plugin_bar') );  # True

    - installed()

        Returns a list of all installed Praat plugins. See _is\_plugin()_ for the
        criteria they need to fulfill.

            my @installed = installed();
            print "$_\n" foreach (@installed);

    - known()

        Returns a list of all plugins known by **CPrAN**. In practice, this is the list
        of plugins whose descriptors have been saved by `cpran update`

            my @known = known();
            print "$_\n" foreach (@known);

    - dependencies()

        Query the desired plugins for dependencies.

        Takes either the name of a single plugin, or a list of names, and returns
        an array of hashes properly formatted for processing with order\_dependencies()

    - order\_dependencies()

        Order required packages, so that those that are depended upon come up first than
        those that depend on them.

        The argument is an array of hashes, each of which needs a "name" key that
        identifies the item, and a "requires" holding the reference to an array with
        the names of the items that are required. See dependencies() for a method to
        generate such an array.

        Closely modeled after http://stackoverflow.com/a/12166653/807650

    - yesno()

        Gets either a _yes_ or a _no_ answer from STDIN. As arguments, it first
        receives a reference to the options hash, followed by the default answer (ie,
        the answer that will be entered if the user simply presses enter).

            my $opt = ( yes => 1 );            # Will automatically say 'yes'
            print "Yes or no? [y/N] ";
            if (yesno($opt, 'n')) { print "You said yes\n" }
            else { print "You said no\n" }

        By default, responses matching /^y(es)?$/i are considered to be _yes_
        responses.

    - compare\_versions()

        Compares two semantic version numbers that match /^\\d+\\.\\d+\\.\\d$/. Returns 1 if
        the first is larger (=newer), -1 if the second is larger, and 0 if they are the
        same;

    - get\_latest\_version()

        Gets the latest known version for a plugin specified by name.

    - get\_plugin\_id()

        Fetches the GitLab id for the project specified by name

# AUTHOR

Jos� Joaqu�n Atria <jjatria@gmail.com>

# LICENSE

Copyright 2015 Jos� Joaqu�n Atria

This module is free software; you may redistribute it and/or modify it under
the same terms as Perl itself.

# SEE ALSO

App::Cmd, YAML::XS, CPrAN::Command::remove, CPrAN::Command::search,
CPrAN::Command::update>, CPrAN::Command::upgrade, CPrAN::Command::show,
CPrAN::Command::install

# VERSION

0.0.1

# POD ERRORS

Hey! **The above document had some coding errors, which are explained below:**

- Around line 98:

    '=item' outside of any '=over'

- Around line 474:

    You forgot a '=back' before '=head1'
