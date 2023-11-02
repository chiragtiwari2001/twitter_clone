ActiveAdmin.register Post do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :content, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:content, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    id_column
    column :user
    column :content
    column :created_at
    column :updated_at
    actions
  end

  filter :content
  filter :user, as: :select
  filter :created_at
  filter :updated_at
end
