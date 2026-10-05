# Video Store — Coding Exercise

You've inherited a small Ruby codebase that manages a video rental store. It models `Movie`, `Rental`, and `Customer`, and its main user-facing feature is `Customer#statement`, which prints a plain-text rental record:

```
Rental Record for Martin
 Plan 9 3.5
 Dune 6
 Ratatouille 3.0
Amount owed is 12.5
You earned 4 frequent renter points
```

A test suite pins down the current behavior of `statement` across the different pricing rules. You can run it with:

```
ruby test/test_statement.rb
```

The only dependency is `minitest`, which ships with Ruby.

## The new requirement

Marketing wants to start emailing customers their rental records. They've asked for an **HTML version** of the statement that contains the same information as the plain-text version but is formatted for display in a web page.

For the statement above, the HTML output might look something like:

```html
<h1>Rental Record for <em>Martin</em></h1>
<p>
  Plan 9: 3.5<br />
  Dune: 6<br />
  Ratatouille: 3.0<br />
</p>
<p>Amount owed is <em>12.5</em></p>
<p>On this rental you earned <em>4</em> frequent renter points</p>
```

The exact markup is up to you — just keep all the information from the plain-text version visible.

## Your task

1. Add an `html_statement` method that produces the HTML version of a customer's rental record.
2. Add tests covering its behavior.
3. The existing `statement` tests must continue to pass — the plain-text output should not change.

## Guidelines

- Aim for code you'd be comfortable maintaining. The interviewer is interested in _how_ you arrive at your solution as much as the final result — please think out loud as you work.
- You're free to restructure `Customer`, `Rental`, and `Movie` however you see fit. Renaming, extracting, moving, or splitting things is fair game.
- If something in the existing code makes the new requirement awkward, feel free to address it as part of the task.
- No need to add gems or change the test setup. Stick with `minitest` and a single `ruby test/test_statement.rb` command.

### Anticipated change

Marketing has also mentioned they expect to keep tweaking pricing rules and adding new categories over the next few quarters. Keep that in mind as you decide where the new logic lives — a future engineer should be able to add the next category without hunting through the codebase.
