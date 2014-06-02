
class GithubClaimModules extends require "widgets.base"
  inner_content: =>
    h2 "Claim Modules"
    p ->
      text "The following modules can be automatically claimed by your account
      based on the GithubAcounts you've linked. You can link a new GitHub
      account from the "
      a href: @url_for("user_settings"), "User Settings page"
      text ". When you claim a module it is copied into your account and your
      copy takes the old module's place in the root manifest."

    @render_modules @claimable_modules

    if next @claimable_modules
      form action: "", method: "POST", ->
        button onclick: [[
          this.innerHTML = 'Loading...';
          var _this = this;
          setTimeout(function() {
            _this.disabled = true;
          }, 1);
        ]], "Claim these modules"

    hr!
    h2 "Already Claimed"
    p "You've already claimed the following modules. They will automatically be
    updated if the LuaRocks mirror is updated."

    @render_modules @linked_modules
