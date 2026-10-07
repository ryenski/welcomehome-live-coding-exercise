# Pet Hotel — Coding Exercise

You've inherited a small Ruby codebase for a pet hotel. It models `Pet`, `Stay`, and `Owner`, and its main user-facing feature is `Owner#invoice`, which prints a plain-text invoice for an owner's pets:

```
Pet Hotel invoice for Sam
 Biscuit 32.5
 Noodle 75
 Bubbles 10.0
Amount owed is 117.5
You earned 4 treat points
```

A test suite pins down the current behavior of `invoice` across the different pricing rules. You can run it with:

```
ruby test/test_invoice.rb
```

The only dependency is `minitest`, which ships with Ruby.

## The new requirement

The hotel wants to start emailing owners their invoices. They've asked for an **HTML version** of the invoice that contains the same information as the plain-text version but is formatted for display in an email.

For the invoice above, the HTML output might look something like:

```html
<div>
  <h1>Pet Hotel invoice for <em>Sam</em></h1>
  <ul>
    <li>Biscuit: 32.5</li>
    <li>Noodle: 75</li>
    <li>Bubbles: 10.0</li>
  </ul>
  <p>Amount owed is <em>117.5</em></p>
  <p>On these stays you earned <em>4</em> treat points</p>
</div>
```

The exact markup is up to you. Just keep all the information from the plain-text version visible.

## Your task

1. Add an `html_invoice` method that produces the HTML version of an owner's invoice.
2. Add tests covering its behavior.
3. The existing `invoice` tests must continue to pass. The plain-text output should not change.

## Guidelines

- Aim for code you'd be comfortable maintaining. The interviewer is interested in _how_ you arrive at your solution as much as the final result, so please think out loud as you work.
- You're free to restructure `Owner`, `Stay`, and `Pet` however you see fit. Renaming, extracting, moving, or splitting things is fair game.
- If something in the existing code makes the new requirement awkward, feel free to address it as part of the task.
- No need to add gems or change the test setup. Stick with `minitest` and a single `ruby test/test_invoice.rb` command.

### Anticipated change

The hotel expects to keep adjusting its rates and to start accepting new kinds of pets over the next few quarters. Keep that in mind as you decide where the new logic lives. A future engineer should be able to add the next kind of pet without hunting through the codebase.
