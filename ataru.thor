# -*- coding: utf-8 -*-
require 'im-kayac'
require 'securerandom'

class Ataru < Thor
  
  desc 'num4', "ナンバーズ4の数字を自動的に生成してくれるコマンド"
  def num4
    lucky_number = SecureRandom.random_number(9999)
    imPost(lucky_number.to_s, 'num4')
  end

  desc 'loto6', "ロト6の数字を自動的に生成してくれるコマンド"
  def loto6
    lucky_numbers = []

    while 6 > lucky_numbers.length do
      lucky_number = SecureRandom.random_number(43)
      next if lucky_number > 43 || lucky_number == 0
      next if lucky_numbers.index(lucky_number)

      lucky_numbers.push(lucky_number)
    end

    imPost(lucky_numbers.to_s, 'loto6')
  end
  
  private
  def imPost(content, type)
    case type
    when 'num4'
      type = "【ナンバーズ4】"
    when 'loto6'
      type = "【ロト6】"
    end
    day = Time.now.strftime("%m月%d日")
    content = type + day + ": " + content
    
    ImKayac.to('Konboi').post(content)    
  end
end
