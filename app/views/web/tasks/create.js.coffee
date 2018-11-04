<% partial = render partial: 'task',
                    locals: { task: @task, presenter: @presenter } %>

$("#task_id_#{'<%= @task.id %>'}").replaceWith '<%= j(partial) %>'
