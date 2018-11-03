<% partial = current_user.admin? ? 'web/admin/tasks/task' : 'task' %>
<% rendered = render partial: partial, locals: { task: @task } %>
$("#task_#{'<%= @task.id %>'}").replaceWith '<%= j(rendered) %>'
