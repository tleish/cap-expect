# Capistrano Expect

Runs custom expect scripts using Capistrano variables.


## Installation With specific_install

    $ gem install specific_install
    $ gem specific_install git@github.com:tleish/cap-expect.git

## Installation From Source

    $ git clone git@github.com:tleish/cap-expect.git cap_expect    
    $ cd cap_expect
    $ rake install

Create .capx.yaml file in Project or HOME root

    $ capx init

Edit this file with your expect script changes
    
## Basic Usage

Cd to directory with capfiles, and use the following commands

List methods

    $ capx
    
List variables

    $ capx variables
    $ capx variables capfile
    
Print expect script for debuggins
    
    $ capx print
    $ capx print capfile
    
## Custom Expect Scripts

Run custom expect script with

    $ capx [custom_method] [capfile]

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tleish/cap-expect.

