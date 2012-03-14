class CreateAppeals < ActiveRecord::Migration
  def change
    create_table :appeals, :force => true do |t|
      t.references  :deleted_by
      t.references  :section
      t.references  :topic
      t.boolean     :public
      t.datetime    :deleted_at
      t.string      :answer_kind
      t.string      :code
      t.string      :email
      t.string      :name
      t.string      :surname
      t.string      :patronymic
      t.string      :phone
      t.string      :root_path
      t.string      :social_status
      t.string      :state
      t.string      :user_agent
      t.string      :user_ip
      t.string      :user_proxy_ip
      t.string      :user_referrer
      t.text        :text
      t.timestamps
    end
  end
end
