ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Posts" do
          ul do
            Post.all do |post|
              li link_to(post.title, admin_post_path(post))
            end
          end
        end
      end

      column do
        panel "New Email to Users" do
          para "Somehow create a form that will send an eamil to everyone that is a user."
          render 'elements/add_upgrade.html.erb'
        end
      end
    end
  end # content
end
