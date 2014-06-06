# coding: utf-8

# Stringクラスの拡張
class String

	# Wikiに変換する
	def convert_markdown_to_wiki

		# 斜体
		self.convert_italic
		# 太字
		self.convert_strong
		# 打ち消し線
		self.convert_strikethrough
		# 見出し
		self.convert_heading
		# 順序なしリスト
		self.convert_unordered_list
		# 順序つきリスト
		self.convert_ordered_list

		return self
	end

	# 太字を変換する
	def convert_strong
		self.gsub!(/\*\*([^\*]+?)\*\*[^\*|$]/, '*\1*')
		return self
	end

	# 斜体を変換する
	def convert_italic
		self.gsub!(/\*([^\*]+?)\*[^\*|$]/, '_\1_')
		return self
	end

	# 打ち消し線を変換する
	def convert_strikethrough
		self.gsub!(/~(.+?)~/, '-\1-')
		return self
	end

	# 見出しを変換する
	def convert_heading
		/(#+)/ =~ self

		if $1.nil?
			return self
		end

		tag = "h#{$1.length}."
		self.gsub!(/(#+)/, tag)
		return self
	end

	# 順序無しリストを変換する
	def convert_unordered_list(space = nil)
		space ||= '\t'

		/(#{space}+\*)/ =~ self

		if $1.nil?
			return self
		end

		symbol = '*'
		$1.scan(/\t/).size.to_i.times do
			symbol += '*'
		end

		self.gsub!(/(#{space}+\*)/, symbol)
		return self
	end

	# 順序ありリストを変換する
	def convert_ordered_list(space = nil)
		space ||= '\t'

		/(#{space}+[0-9]+?\.)/ =~ self

		if $1.nil?
			return self
		end

		symbol = '#'
		$1.scan(/\t/).size.to_i.times do
			symbol += '#'
		end

		self.gsub!(/(#{space}+[0-9]+?\.)/, symbol)
		return self
	end
end