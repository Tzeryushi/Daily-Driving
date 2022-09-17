# Daily-Driving
### A small app to give my days direction.

This is a relatively simple program that allows a user to generate a number of tasks, ideally things like hobbies, which will then be used to create a daily list of activities to focus on. The user can change the probability of a task to appear in the daily list, which uses a discrete CDF when propagating. Users can mark tasks as complete, and at the end of the day can submit their tasks, which will add a mark to a "calendar" depending on how many tasks they were able to address.

This program is designed to assist people who have picked up too many hobbies, and suffer from choice paralysis or laziness when deciding what to do with their time.

## Version 0.1

Absolutely basic features. Users can add and remove tasks, set their weights, and generate daily tasks. They can regenerate or remove tasks they don't like, though this behaviour may become a toggle in the future. Tasks can be forced as well. Daily tasks can be completed and added to the finished section. User determines the end of a day, and can submit their finished tasks to earn a calendar mark based on the percentage of tasks completed.

## Future Additions

As it stands, the program relies a lot on the user's honesty. In the future, buttons will be removed and the program will auto-propagate and submit based on a 24-hour period that the user can define (for example, you could have your dailies reset at 7 in the morning).

A system might be implemented that allows the user to specify a range of time they will spend on any given day, and the program will split the dailies up into time blocks (this might be a tad oppressive). Alternatively, the user might specify a range of time for any random task, and it will randomly generate an amount of time to work; or, the user can submit how much free time they'll have on any given day, and the program will slot in tasks that fit into the timeframe.

## Focus
Make a scene that can be instanced with custom descriptions, added to a list, edited, and removed
Make a scrolling pool of these added scenes
At the start of each day random elements in the pool will be added to the daily tasks
Accomplishing the tasks for the day will mark a completed day in the calendar
Resets next day

Can edit items with special tags, such as increased priority or permanent slot
Items will gain more weight in the random pool the longer they have gone undone.
Rewards for consistency? Pretty colors?
