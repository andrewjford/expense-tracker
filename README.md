An expense tracking web app made in Sinatra. Currently hosted at https://oozetracker.herokuapp.com/.

Overview

This is a simple spending tracker to record expenses. Users enter transactions by date, amount and category by following the link from the home page, expense page, or navigation bar. A summary of monthly expenses is available on the home page. Much of the content in the tables are links, so feel free to explore the functionality.

Installation

Run 'bundle install'. Start server with 'rackup config.ru'. Open provided local address in web browser.

Details

The home summary page allows users to cycle through months by way of the prev and next buttons. The category links in these summary tables link to the details of that category for that given month.

The expenses page lists the 20 most recent expenses by date. A link is available on this page to show all expenses. The categories and descriptions shown in these tables are links to filtered expense listings. The amounts are links to the individual expense's page. From the individual expense page the user can choose to edit or delete the expense.

The categories page lists the default categories provided as well as any categories added by the user. New categories can be added from this page. Each category listed is a link to that individual category page. The individual category page lists all expenses that use the category, and give the user the option to edit the category name or delete the category (if no expenses use it).

License

See license.md file.
