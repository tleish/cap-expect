
# rcap list
As a developer
I want see a list of capfiles in my project
So that I can see which capfile I want to pass

## Scenario 1: List Config of Capfile(s)
Given capistrano is configured
When the user runs config action with one or more capfiles
Then read the configuration(s)
  and print the configuration summaries to the terminal

---------------

# rcap config [capfile]
As a developer
I want see the basic capistrano configuration in my project
So that I can quickly see the host deployment information

## Scenario 1: List Config of Capfile(s)
Given capistrano is configured
When the user runs config action with one or more capfiles
Then read the configuration(s)
  and print the configuration summaries to the terminal

---------------

# rcap ssh [capfile]
As a developer
I want to ssh to the deployment location of a capistrano host:directory in my project
So that I can perform server functions in my terminal

## Scenario 1: SSH to Host in Capfile
Given capistrano is configured with a capfile
When the user runs ssh action with a given capfile
Then ssh to that server

## Scenario 1: SSH to Host in Capfile with No Gateway
Given capistrano is configured with a capfile with no Gateway defined
When the user runs ssh action with that given capfile
Then ssh to that server using a default gateway

---------------

# rcap console [capfile]
As a developer
I want to start a rails console in the rails deployment location of a capistrano host:directory in my project
So that I can perform server functions in my terminal

## Scenario 1: Rails Console on Host in Capfile
Given capistrano is configured with a capfile
When the user runs console action with a given capfile
Then ssh to that server
  and run a rails/console

---------------

# Capfile Chooser
As a developer
I want help choosing which capfile to use
So that I can execute commands against it

## Scenario 1: Multiple Capfiles - Multiple Choice
Given capistrano is configured with multiple capfiles
When the user runs command without a capfile defined
Then present a list of all capfiles for them to choose from
  and default to the first host listed in the app role

## Scenario 2: Multiple Capfile Pattern - Multiple Choice
Given capistrano is configured with multiple capfiles
When the user runs command with a capfile pattern
  and the results includes multiple capfiles
Then present a list of all capfiles for them to choose from

## Scenario 3: Process Choice Multiple Capfiles
Given a multiple choice of capfiles has been presented to user
When the user chooses a capfile option
Then continue with the primary command using the capfile option

## Scenario 4: One Capfile
Given capistrano is configured with one capfile
When the user runs command without a capfile defined
Then continue with the primary command using the capfile

## Scenario 5: No Capfile
Given no capfile is found
When the user executes an action
Then print an error to the terminal
 and include a did-you-mean? list of capfiles
 
---------------

# Capfile Config

## Scenario 1: Capfile
Given a capfile exists
When the configuration is requested based on the path
Then return a configuration
  
## Scenario 1: Null Capfile
Given a capfile does NOT exists
When the configuration is requested based on the path
Then return a NULL configuration
 
