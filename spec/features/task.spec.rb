require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  scenario "タスク一覧のテスト" do

    visit tasks_path
    
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario "タスク作成のテスト" do

    visit new_task_path
    
    fill_in 'new_title', with: 'test_task_01'
    fill_in 'new_content', with: 'testtesttest'
    
    click_on '登録する'
    
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
  end

  scenario "タスク詳細のテスト" do
    Task.create!(id: '1', title: 'test_task_01', content: 'testtesttest', deadline: '4月30日', priority: '1', status: 'a')
    
    visit task_path(1)
  
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content '4月30日'
    expect(page).to have_content '1'
    expect(page).to have_content 'a'
    
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    # backgroundに必要なタスクデータの作成処理が書かれているので、ここで書く必要がない
    visit tasks_path
    # タスクが作成日時の降順に並んでいるかのテスト
    # what: これは配列の順番を見るために作ったコード
    # how；　配列で取得するためにviewからだったらall modelからならallやwhere
    # why: 順番を確かめるためには一つの変数で複数の値を順番通りもてる配列を使わなきゃいけないから
    # ts = Task.order(created_at: "DESC").map do |task|
    #   task.title
    # end
    ts = Task.order(created_at: "DESC").pluck(:content)
    expect(all(".task-item__content").map(&:text)).to eq ts
    # expect(all(".task-item__title").map(&:text)).to eq ts
  end
end
# t = all(".task-item__title")¥
# t == [
#   {title: " "},
#   {title: "a"},
# ]
# t[0].title

# {title: " "}[:title]

# [0," hfejkwa", "ewa"] == {0: 0, 1: " hfejkwa", 2: "ewa" }
# [0," hfejkwa", "ewa"][1]
# {0: 0, 1: " hfejkwa", 2: "ewa" }[:1]

# class Array
#   def pluck(property)
#     self.map{ |val| val.property }
#   end
#   # def pluck(property)
#   #   self.map{ |val| val[:property] }
#   # end
# end