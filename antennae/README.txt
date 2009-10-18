Paperworld is a set of libraries that help you accomplish some fairly complex tasks like synchronising object
states across multiple clients. 

Paperworld provides code for flash clients (Actionscript), Unity3D clients (C#) and Red5 server applications (Java).

Getting Started

To get up and running with Paperworld you'll need to follow a few relatively simple steps:

1 - Check out the Antennae project from googlecode

http://code.google.com/p/antennae/

into a directory at the same level as the paperworld directory this file is in. The Antennae project is basically a set of 
Ant files that paperworld needs in order to build its libraries and example applications.

2 - Set up your user properties

Once you've checked out the Antennae code take a look at the build-user.properties.* files in the same directory as this file.

You'll notice there's one for windows and one for mac. Select the one that matches the platform you're using and copy it, renaming
the file to remove the win/mac ending - so you're file will be called build-user.properties

Now open that build-user.properties file and take a look inside. You'll need to replace the currect property values with the
correct ones for your system. So the properties point to the correct directory for your flex framework etc. etc.

3 - Build paperworld

Now you should be able to open a command prompt or terminal window and navigate to your paperworld directory and run

ant build

This will run through all the libraries and example projects and build them all for you - the example clients will get built in their 
respective directories and the example server applications will be distributed to the Red5 installation you defined in your
build-user.properties files... so you should then be able to start/restart Red5 and connect from any of the client examples.