class UserSettingsSecurityAudit extends require "widgets.user_settings_page"

  @include "widgets.table_helpers"

  settings_content: =>
    p "On March 4th, 2019, we were made aware of a vulnerabilility on
    LuaRocks.org that would theorically allow someone to guess generated API
    keys and password reset tokens by using knowledge of how we were using the
    random number generator. Based on our own audits we don't have any reason
    to believe that this vulnerabilility was exploited, but we're making as
    much data open as possible to help you identify any suspicious activity. We
    encourage you to check the modules on your account."
    
    p "We're providing this page so you can review all rockspecs and server
    logs associated with your account. The vulnerabilility has existed since
    LuaRocks.org has had an API so we've provided logs all the way back to the
    beginning."

    p "Because of how our logging was configured, we do not have IP addresses
    for server log entries. (This has been fixed) We still recommend reviewing
    the activity and dates to see if you can identify any suspicious activity
    on your account."

    p ->
      text "You can read our full statement here, along with what we're changing to prevent issues like this in the future. "
      strong "TODO: coming soon"

    p "Thanks"

    h3 "Your Modules"
    @column_table @user\get_modules!, {
      {"Module", (mod) ->
        a href: @url_for(mod), mod\name_for_display!
      }
      {"Audit", (mod) ->
        strong ->
          a href: @url_for("audit_module", user: mod\get_user!, module: mod),
            "Review Rockspec changes"
      }
      "created_at"
      "updated_at"
      {"Latest version", (mod) ->
        version = unpack mod\get_versions!
        a href: @url_for(version), version\name_for_display!
      }
      {"Latest version date", (mod) ->
        version = unpack mod\get_versions!
        @render_date version.created_at
      }
    }

    h3 "Server Logs"

    p ->
      em "All times are in UTC"

    a href: "?download", class: "button", "Download Raw Logs"

    @column_table @server_logs, {
      {"log_date", label: "Date"}
      {"log", (l) ->
        code l.log\gsub "^127%.0%.0%.1 %- %- %[[^]]+%]", ""
      }
    }

