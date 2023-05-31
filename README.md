Scripts that query [TMDB](https://www.themoviedb.org) for movies covered in [The Rewatchables](https://www.theringer.com/the-rewatchables) podcast that are available on [Netflix](https://www.netflix.com/) in the U.S.

## Prerequisites
If Docker is not being used, you will need to have:

* [Python 3](https://www.python.org/downloads/)
* [tmdbv3api](https://pypi.org/project/tmdbv3api/)
* [jq](https://jqlang.github.io/jq/)
* [curl](https://curl.se/)

## Run Instructions
If you want to run the scripts, you will need a TMDB account, which allows you to then create [an API key](https://www.themoviedb.org/settings/api). Once you have obtained the key, set it as an environment variable:

```export TMDB_API_KEY=YOUR_API_KEY```

You can then run:

```./rewatchables-on-netflix.sh```

This will trigger the calls to the TMDB API to see if movies from The Rewatchables are available on Netflix in the U.S. The script prints out the available movies to stdout, and also writes to the file `available/available_on_netflix.txt`. Note that this file is also updated in this Github repo once a week on Tuesdays. A Github Actions job runs to accomplish this.

To also have the scripts update to a repo that you have (say, if you fork this one), specify the following command line options:

```./rewatchables-on-netflix.sh -g -u GITHUB_USERNAME```

## Docker Instructions
Alternatively, you can run this via docker. Assuming you have Docker desktop installed, just do:

```docker image build -t rewatchables:0.0.1 .```
```docker run --env-file .env rewatchables:0.0.1```

Where .env has the following contents:

```TMDB_API_KEY=YOUR_TMDB_API_KEY```
```GH_TOKEN=YOUR_GITHUB_TOKEN```