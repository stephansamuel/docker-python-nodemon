# docker-python-nodemon

An automated Docker environment for Python development using `nodemon` to watch for file changes.

## Development-time use

Docker (including `docker-compose`) must be installed. Likely, you have `git` already installed as well. Use whatever code editor you like. Run:

```
docker-compose up
```

If you change the name of the root Python package (and you probably will unless your project is called, "hello, world"), update `docker-compose.yml` and the Dockerfile. Additional libraries may be added using Docker volumes. After making changes, run:

```
docker-compose build
```

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

## What's going on

The simple description provided here should help to understand what's going on, so that you can modify this project to meet your needs.

1. The primary `Dockerfile` for the Python script to run as the entry point is in `assets/dockerfiles`.
1. The `docker-compose.yml` automator runs the container for Python.
1. The Python source is mounted as a volume on the Docker container so the local file system matches what's in the run-state Python container.
1. The Python container, indended to be the runtime, installs `node`, then `npm`, then `nodemon`.
1. On run, `nodemon` watches for file system changes and re-runs Python when they occur.
