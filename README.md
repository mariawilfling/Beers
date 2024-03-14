#  Beers - Beer Library App


## The App
1. The BeerListView is opened and starts loading the first page or beers as well as a random beer to diplay.
2. The images of the beers are loaded.
3. Tapping on a beer from the list or the beer of the day the detail view is opened and the beer object is injected.
4. For filtering the beers, filter settings are saved and passed in the request. (This couldn't be fully tested, because Punk API was down.)

## Open Points

Due to the limited time, I had to find an end for this challenge at some point. Still I find a lot of open points and many things to improve.
There might be more things to improve, but following points I see at the moment:

- adding a launch screen as an intro to the app while beer data is still loading
- display an error message to the user when beer data cannot be loadede, e.g. server is down or no internet connection
- the segmented control in the filter view is not ideal, because it forces the user to make a choice and the filter possibilities are limited. I would have loved to change it to sliders with 2 handles (for min & max values), but there wasn't enough time.
- the random beer box can be closed, but I didn't add any possibility for the user to see it again
- the images could be cached to avoid loading them again
- I saw some request time out messages in the console, but couldn't check anymore because the PunkAPI was down from Thursday morning
- write unit and ui tests (I couldn't think of a useful "quick" unit test. The networking could be tested, but would need mock data)
