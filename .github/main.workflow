workflow "Launch hackathon" {
  on = "repository_dispatch"
  resolves = [
    "Create KKTIX event",
    "Create Hackfoldr",
    "Create Typeform",
  ]
}

action "Create KKTIX event" {
  uses = "docker://node:11-alpine"
  runs = "./.github/actions/kktix.js"
  secrets = ["ONEBUTTON_KKTIX_PASSWORD"]
}

action "Create Hackpad" {
  uses = "docker://node:11-alpine"
  runs = "./.github/actions/hackpad.js"
  secrets = ["ONEBUTTON_HACKPAD_SECRET"]
}

action "Create Google Spreadsheet schedule" {
  uses = "docker://node:11-alpine"
  runs = "./.github/actions/spreadsheet.js"
  secrets = ["ONEBUTTON_GOOGLE_SECRET_BASE64"]
}

action "Create Hackfoldr" {
  needs = [
    "Create Hackpad",
    "Create Google Spreadsheet schedule",
  ]
  uses = "docker://node:11-alpine"
  runs = "./.github/actions/hackfoldr.js"
}

action "Create Typeform" {
  uses = "docker://node:11-alpine"
  runs = "./.github/actions/typeform.js"
  secrets = ["ONEBUTTON_TYPEFORM_TOKEN"]
}
