ActiveAdmin.register Comment, as: "PostComment" do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :post_id, :comment
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :post_id, :comment]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :user
    column :post
    column :comment
    column :created_at
    column :updated_at
    actions
  end

  filter :comment
  filter :created_at
  filter :updated_at
end
