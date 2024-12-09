# Whitenoise pathing bug reproduction

## Reproduction Steps

- Clone this repository.
- Create a virtual environment.
- Activate the virtual environment and install the packages defined by the requirements.txt.
- Run `./manage.py migrate`
- Run `./manage.py runserver` to start the webserver in debug mode.
- Observe that the home page works without errors by navigating to http://localhost:8000/.
- Stop the web server by pressing CTRL+C in your terminal.
- Now run the collectstatic command like this: `./manage.py collectstatic`.
- Now run the production server like this: `./run.sh`
- Observe that the home page is now returns a 500 status code by navigating to http://localhost:8000/.

## What's the problem?

Here's the error:

`ValueError: Missing staticfiles manifest entry for '/picture.jpg'`

Here's the line that caused it in `home/templates/home.html`:

`<img src="{% static "/picture.jpg" %}" alt="a mountain" style="height: 20rem;">`

If you change the line to this it works:

`<img src="{% static "picture.jpg" %}" alt="a mountain" style="height: 20rem;">`

## Why is this a problem?

It's a problem because it means that what is a valid string for the `static` tag in development may
not be valid in production.

## What's the fix?

I propose that whitenoise ignore the slash at the beginning of file paths. So `/picture.jpg` will get turned into `picture.jpg`.
