# docker-python-nodemon

An automated Docker environment for Python development using `nodemon` to watch for file changes.

## Rationale

This is a wild hack.

In most non-Python development environments I've worked in, there is a watch option on the runtime. It watches development folders then re-runs the script (or compiler) each time changes are made to the source. I cannot find this option on the `python` executable.

The next-best option I found uses a file system watcher library in Python. While this is good, it causes the system under test, the Python script, to be mixed with the environment details. I do not care for this model.

My goals are as follows:

 - **A save-to-run framework for executing Python scripts.** The source file of record is the script source on the local file system. Changes made to the source cause the script to be re-run.
 - **Separation of devops implementation from code.** The code runs as a pure library that is unaware of its own existence as an in-development library.
 - **No pollution of the development host.** The requirements are minimal and include only packages that are common. Libraries do not need to be installed on the local system.
 - **Simple and orchestrated containerization.** Docker works for me. There is a `docker-compose.yml` file that automates containers. 
 - **Standard implementation.** Even if not necessarily orthodox, the system uses standard components. In this case, the `nodemon` implementation is out-of-the-box.
 - **Useful flexibility.** Adding another service, whether to do something to the Python, or to do something around it, should be easy and as unconstrained as possible. Add another container with separate concerns without much additional overhead or
   complicated configuration.

## Development-time use

Docker (including `docker-compose`) must be installed. Likely, you have `git` already installed as well. Use whatever code editor you like. Run:

```
docker-compose up
```

