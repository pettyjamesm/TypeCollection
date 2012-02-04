require 'typecollection'
require 'builder'

class XMLGenerator
	include TypeCollection::Base

	class UnimplementedMethod < StandardError; end

	def self.process_elements(elements)
		raise XMLGenerator::UnimplementedMethod.new("#{self.name} doesn't implement process_elements!")
	end

	def self.get_writer_instance; FileWriter.get_associated_type(self).new(); end

	def self.generate_feed(elements)
		writer = self.get_writer_instance()
		writer.write_contents(self.process_elements(elements))
	end

	def self.generate_all_feeds(elements)
		XMLGenerator.all_types.each do |klass|
			klass.generate_feed(elements)
		end
		true
	end
end

class FileWriter
	include TypeCollection::Base

	class UnimplementedMethod < StandardError; end

	def self.file_name; "#{self.inferred_type}.xml"; end

	def write_contents(string_contents)
		raise FileWriter::UnimplementedMethod.new("#{self.name} doesn't implement write_contents!")
	end
end

class FirstXMLGenerator < XMLGenerator

	def self.process_elements(elements)
		xml = Builder::XmlMarkup.new()
		xml.body do
			xml.name "First" # => Alternatively, self.inferred_type
			xml.elements do
				elements.each do |element|
					xml.element "One way to handle #{element.to_s}"
			  end
			end
		end
		xml.target!
	end
end

class FirstFileWriter < FileWriter
	def write_contents(string_contents)
		File.open(self.class.file_name, 'w'){|f| f.write(string_contents) }
	end
end

class SecondXMLGenerator < XMLGenerator
	def self.process_elements(elements)
		xml = Builder::XmlMarkup.new()
		xml.body do
			xml.name self.inferred_type
			xml.elements do
				elements.each do |element|
				  xml.element "Another Way to Handle #{element.to_s}"
				end
			end
		end
		xml.target!
	end
end

class SecondFileWriter < FileWriter
	def write_contents(string_contents)
		File.open(self.class.file_name, 'a'){|f| f.write(string_contents) }
	end
end