#!/usr/local/bin/python3
#
# Simple script to query the TMDB API for a given list
# of movies and their associated TMDB ids. Release year
# is not used, but included for clarity on which version
# of the film is being retrieved (at a glance).
#
import tmdbv3api, csv, time, argparse, os

parser = argparse.ArgumentParser()
parser.add_argument("file")

# Create an instance of the TMDB API client
tmdb = tmdbv3api.TMDb()
tmdb.api_key = os.getenv('TMDB_API_KEY')

# Create an instance of the Movie API client
movie = tmdbv3api.Movie()

args = parser.parse_args()

# CSV file with TMDB IDs passed via the command line
tmdb_id_csv_file = args.file

with open(tmdb_id_csv_file, 'r') as csv_file:
    next(csv_file)
    reader = csv.reader(csv_file)
    for row in reader:
        # grab the movie ID from the CSV file
        try:
            movie_id = row[2]
        except:
            print(f"'{row[0]}' is the last show that was being processed")
        # Get the watch provider information for the movie
        try:
            watch_providers = movie.watch_providers(movie_id)
        except:
            time.sleep(15)
            print(f"'{row[0]}' is the last show that was being processed")
            watch_providers = movie.watch_providers(movie_id)

        # Check if watch provider information is available for the US market
        if 'US' in watch_providers[
                'results'] and 'flatrate' in watch_providers['results']['US']:
            us_providers = watch_providers['results']['US']['flatrate']
            for provider in us_providers:
                # Final check for Netflix availability
                if provider['provider_name'] == "Netflix":
                    print(
                        f"'{row[0]}' is available on Netflix in the US market")
